# Complete Setup Guide

This guide provides step-by-step instructions for setting up OpenTrail from scratch.

## Prerequisites

Before starting, ensure you have:

1. **Node.js 20+**
   ```bash
   node --version  # Should be v20.0.0 or higher
   npm --version
   ```

2. **pnpm** (recommended package manager)
   ```bash
   npm install -g pnpm
   pnpm --version
   ```

3. **Docker & Docker Compose**
   ```bash
   docker --version
   docker-compose --version
   ```

4. **Git**
   ```bash
   git --version
   ```

5. **Code Editor** (VS Code recommended)

## Step 1: Project Setup

### 1.1 Create Project Directory

```bash
mkdir -p ~/Projects/OpenTrail
cd ~/Projects/OpenTrail
git init
```

### 1.2 Create Folder Structure

```bash
# Create main directories
mkdir -p apps/{frontend,backend}
mkdir -p docker
mkdir -p workflows
mkdir -p scripts
mkdir -p docs
mkdir -p .github/workflows

# Create initial files
touch .gitignore
touch README.md
touch ARCHITECTURE.md
```

### 1.3 Initialize Monorepo

Create `pnpm-workspace.yaml`:
```yaml
packages:
  - 'apps/*'
```

Create root `package.json`:
```json
{
  "name": "opentrail",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "pnpm -r --parallel run dev",
    "build": "pnpm -r --parallel run build"
  }
}
```

Install root dependencies:
```bash
pnpm install
```

## Step 2: Backend Setup

### 2.1 Create Backend Application

```bash
cd apps/backend

# Initialize Node project
pnpm init -y

# Install core dependencies
pnpm add express cors dotenv helmet morgan uuid
pnpm add @prisma/client zod joi jsonwebtoken bcryptjs winston

# Install dev dependencies
pnpm add -D typescript ts-node @types/node @types/express nodemon prisma
pnpm add -D jest @types/jest ts-jest eslint prettier
```

### 2.2 Create Backend Folder Structure

```bash
# Create src directory structure
mkdir -p src/{config,routes,controllers,services,middleware,utils,types,validators}
mkdir -p prisma
mkdir -p tests/{unit,integration}

# Create main entry files
touch src/main.ts
touch src/server.ts
touch tsconfig.json
touch .env.local
touch .env.example
```

### 2.3 Create TypeScript Configuration

Create `tsconfig.json`:
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### 2.4 Initialize Prisma

```bash
pnpm dlx prisma init
```

Update `.env.local`:
```env
DATABASE_URL="postgresql://postgres:opentrail_password@localhost:5432/opentrail_db"
JWT_SECRET=dev_secret_key
JWT_EXPIRATION=7d
NODE_ENV=development
PORT=3001
FRONTEND_URL=http://localhost:3000
```

Create `prisma/schema.prisma` - See [DATABASE.md](./DATABASE.md) for full schema

### 2.5 Create Database Migration

```bash
pnpm prisma migrate dev --name init
pnpm prisma generate
```

## Step 3: Frontend Setup

### 3.1 Create Frontend Application

```bash
cd apps/frontend

# Create Next.js app
pnpm create next-app@latest . \
  --typescript \
  --tailwind \
  --app \
  --src-dir \
  --no-git

# Or manually:
pnpm init -y
pnpm add next react react-dom
pnpm add -D typescript @types/node @types/react @types/react-dom
```

### 3.2 Install Frontend Dependencies

```bash
# UI and state management
pnpm add zustand @tanstack/react-query axios react-hook-form zod

# shadcn/ui
npx shadcn-ui@latest init -d

# Additional UI
pnpm add lucide-react
```

### 3.3 Create Frontend Folder Structure

```bash
# Create src directory structure
mkdir -p src/{app,components,hooks,lib,store,types,styles}

# Create app router structure
mkdir -p src/app/{auth,dashboard}

# Create component directories
mkdir -p src/components/{ui,auth,dashboard,common}
```

### 3.4 Create Environment Files

Create `.env.local`:
```env
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXT_PUBLIC_API_BASE=/api
NEXT_PUBLIC_ENV=development
```

## Step 4: Docker Setup

### 4.1 Create Docker Compose File

Create `docker/docker-compose.yml` - See [README.md](../README.md) for full file

### 4.2 Create Dockerfiles

Create `docker/backend.dockerfile` - See [README.md](../README.md)

Create `docker/frontend.dockerfile` - See [README.md](../README.md)

### 4.3 Build and Start Services

```bash
cd docker

# Build images
docker-compose build

# Start services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

## Step 5: Development Setup

### 5.1 Start Development Servers

```bash
# Terminal 1: Backend
cd apps/backend
pnpm dev:watch

# Terminal 2: Frontend
cd apps/frontend
pnpm dev

# Terminal 3: Database UI
cd apps/backend
pnpm db:studio
```

### 5.2 Verify Everything Works

- Frontend: http://localhost:3000
- Backend: http://localhost:3001
- Health check: http://localhost:3001/health
- Database UI: Run `pnpm db:studio`

## Step 6: Git Setup

### 6.1 Create .gitignore

```
node_modules/
dist/
build/
.next/
.env.local
.env
.DS_Store
*.log
```

### 6.2 Initial Commit

```bash
git add .
git commit -m "Initial project setup with architecture and Docker configuration"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

## Common Issues & Troubleshooting

### Port Already in Use

```bash
# Find process using port
lsof -i :3000
lsof -i :3001
lsof -i :5432

# Kill process
kill -9 <PID>
```

### Database Connection Failed

```bash
# Check Docker containers
docker-compose ps

# Restart PostgreSQL
docker-compose restart postgres

# Reset database
docker-compose down -v
docker-compose up -d postgres
```

### Node Modules Issues

```bash
# Clean install
rm -rf node_modules
pnpm install

# Clear pnpm cache
pnpm store prune
```

## Next Steps

1. Read [ARCHITECTURE.md](../ARCHITECTURE.md) to understand the structure
2. Review the database schema in [DATABASE.md](./DATABASE.md)
3. Start implementing Phase 2 features:
   - GitHub OAuth integration
   - API endpoints
   - Frontend pages

See [README.md](../README.md) for all available commands.
