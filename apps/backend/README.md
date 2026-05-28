# Backend - OpenTrail API Server

Express.js + TypeScript backend for OpenTrail platform.

## Quick Start

```bash
# Install dependencies
pnpm install

# Setup database
pnpm prisma migrate dev --name init
pnpm db:seed

# Run in development
pnpm dev:watch

# Run tests
pnpm test
```

## Scripts

- `pnpm dev` - Start server (single run)
- `pnpm dev:watch` - Start with auto-reload
- `pnpm build` - Compile TypeScript to dist/
- `pnpm start` - Run compiled version
- `pnpm lint` - Lint TypeScript code
- `pnpm format` - Format code with Prettier
- `pnpm type-check` - Type check without build
- `pnpm test` - Run tests
- `pnpm test:watch` - Run tests in watch mode
- `pnpm db:migrate` - Create new migration
- `pnpm db:seed` - Seed database with test data
- `pnpm db:studio` - Open Prisma Studio UI

## Environment Variables

See `.env.example` for all available environment variables.

Create `.env.local` with your settings:

```env
NODE_ENV=development
PORT=3001
HOST=localhost
DATABASE_URL=postgresql://postgres:opentrail_password@localhost:5432/opentrail_db
JWT_SECRET=dev_secret_key
JWT_EXPIRATION=7d
FRONTEND_URL=http://localhost:3000
```

## Folder Structure

```
src/
├── config/          # Configuration (env, database, logger)
├── routes/          # API route definitions
├── controllers/     # Route handlers
├── services/        # Business logic
├── middleware/      # Express middleware
├── utils/           # Utility functions
├── types/           # TypeScript types
└── validators/      # Input validation

prisma/
├── schema.prisma   # Database schema
└── migrations/     # Migration files
```

## API Health Check

```bash
curl http://localhost:3001/health
```

## Database Management

```bash
# View database in UI
pnpm db:studio

# Create migration after schema change
pnpm prisma migrate dev --name describe_change

# Reset database (deletes all data)
pnpm prisma migrate reset
```

## Development Workflow

1. Edit `prisma/schema.prisma` if changing database
2. Run `pnpm prisma migrate dev --name description` to create migration
3. Server auto-reloads (with `pnpm dev:watch`)
4. Test changes at `http://localhost:3001`

See [../../ARCHITECTURE.md](../../ARCHITECTURE.md) for detailed architecture information.
