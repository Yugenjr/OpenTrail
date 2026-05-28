# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy workspace and package files
COPY pnpm-workspace.yaml ./
COPY package.json ./

# Copy frontend package file
COPY apps/frontend/package.json ./apps/frontend/

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY apps/frontend/src ./apps/frontend/src
COPY apps/frontend/public ./apps/frontend/public
COPY apps/frontend/tsconfig.json ./apps/frontend/
COPY apps/frontend/next.config.js ./apps/frontend/
COPY apps/frontend/tailwind.config.ts ./apps/frontend/
COPY apps/frontend/.eslintrc.json ./apps/frontend/

# Build Next.js
WORKDIR /app/apps/frontend
ARG NEXT_PUBLIC_API_URL=http://localhost:3001
ARG NEXT_PUBLIC_ENV=development
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}
ENV NEXT_PUBLIC_ENV=${NEXT_PUBLIC_ENV}
RUN pnpm build

# Runtime stage
FROM node:20-alpine

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Install dumb-init
RUN apk add --no-cache dumb-init wget

# Copy package files
COPY pnpm-workspace.yaml ./
COPY package.json ./
COPY apps/frontend/package.json ./apps/frontend/

# Install only production dependencies
RUN pnpm install --prod --frozen-lockfile

# Copy built Next.js application from builder
COPY --from=builder /app/apps/frontend/.next ./apps/frontend/.next
COPY --from=builder /app/apps/frontend/public ./apps/frontend/public
COPY --from=builder /app/apps/frontend/next.config.js ./apps/frontend/

# Copy node_modules
COPY --from=builder /app/node_modules ./node_modules

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

USER nodejs

# Health check
HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
  CMD wget --quiet --tries=1 --spider http://localhost:3000 || exit 1

EXPOSE 3000

ENTRYPOINT ["dumb-init", "--"]
CMD ["pnpm", "start"]
