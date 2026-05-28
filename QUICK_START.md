# 🚀 OpenTrail - 10-Minute Quick Start

Get OpenTrail running in 10 minutes with Docker or locally.

## Prerequisites Check

Before starting, verify you have:

```bash
node --version        # Should be v20.0.0 or higher
npm --version
pnpm --version        # If not installed: npm install -g pnpm
docker --version
docker-compose --version
git --version
```

---

## Option A: Docker Setup (Easiest) ⭐

**Perfect for beginners. Everything runs in containers.**

### Step 1: Start Docker Services

```bash
# Navigate to project
cd ~/Downloads/OpenTrail

# Go to docker directory
cd docker

# Start all services (database, backend, frontend, n8n)
docker-compose up -d

# Wait ~30 seconds for services to start
# You'll see the containers starting:
# ✓ postgres
# ✓ backend (builds automatically)
# ✓ frontend (builds automatically)
# ✓ n8n
```

### Step 2: Verify Services Started

```bash
# Check if all services are running
docker-compose ps

# You should see:
# NAME              STATUS
# opentrail-postgres      Up (healthy)
# opentrail-backend       Up (healthy)
# opentrail-frontend      Up (healthy)
# opentrail-n8n           Up
```

### Step 3: Access Your Applications

```
✅ Frontend:      http://localhost:3000
✅ Backend API:   http://localhost:3001
✅ API Health:    http://localhost:3001/health (should return {"status":"ok"})
✅ n8n:           http://localhost:5678 (username: admin, password: admin123)
✅ Database UI:   Run: cd ~/Downloads/OpenTrail/apps/backend && pnpm db:studio
```

### Step 4: View Logs

```bash
# See all logs
docker-compose logs -f

# Just backend logs
docker-compose logs -f backend

# Just frontend logs
docker-compose logs -f frontend

# Just database logs
docker-compose logs -f postgres
```

### Step 5: Stop Services (when done)

```bash
docker-compose down          # Stops containers (keeps data)
docker-compose down -v       # Stops AND deletes data
```

---

## Option B: Local Development Setup

**For active development with hot reload on code changes.**

### Step 1: Install Dependencies

```bash
# Go to project root
cd ~/Downloads/OpenTrail

# Install all dependencies (frontend + backend)
pnpm install

# This installs both apps due to pnpm-workspace.yaml
```

### Step 2: Start Database (Docker only)

You still need a PostgreSQL database. Start it with Docker:

```bash
# In a terminal, start just the database
cd docker
docker-compose up postgres n8n -d

# Wait 10 seconds for postgres to start
```

### Step 3: Setup Backend Database

```bash
cd ~/Downloads/OpenTrail/apps/backend

# Create database schema
pnpm prisma migrate dev --name init

# Seed with test data
pnpm db:seed

# You should see:
# ✓ Test user created: test@example.com
# ✓ Test repository created: facebook/react
# ✓ Test opportunity created: Add TypeScript support...
# ✨ Database seeded successfully!
```

### Step 4: Start Services (3 Terminals)

**Terminal 1: Backend**
```bash
cd ~/Downloads/OpenTrail/apps/backend
pnpm dev:watch

# You should see:
# ✓ Server running on http://localhost:3001
# ✓ Environment: development
```

**Terminal 2: Frontend**
```bash
cd ~/Downloads/OpenTrail/apps/frontend
pnpm dev

# You should see:
# ▲ Next.js 14.0.0
# - Local: http://localhost:3000
```

**Terminal 3 (Optional): Database UI**
```bash
cd ~/Downloads/OpenTrail/apps/backend
pnpm db:studio

# Opens http://localhost:5555 to view database
```

### Step 5: Access Applications

Same as Docker option:
```
✅ Frontend:      http://localhost:3000
✅ Backend API:   http://localhost:3001
✅ Database UI:   http://localhost:5555 (if you ran db:studio)
```

---

## Common Tasks

### View Database

```bash
# Local development
cd ~/Downloads/OpenTrail/apps/backend
pnpm db:studio

# Opens browser at http://localhost:5555
```

### Make Database Changes

```bash
# 1. Edit apps/backend/prisma/schema.prisma

# 2. Create migration
pnpm prisma migrate dev --name describe_your_change

# 3. Server auto-reloads (or restart if needed)
```

### Check API is Working

```bash
# Health check
curl http://localhost:3001/health

# Should return:
# {"status":"ok","timestamp":"2024-01-15T10:30:00.000Z"}
```

### View Logs

**Docker:**
```bash
cd docker
docker-compose logs -f backend  # Backend logs
docker-compose logs -f frontend # Frontend logs
```

**Local:**
```bash
# Logs appear in terminal where you ran pnpm dev:watch
```

### Reset Everything

```bash
# Docker (delete all data!)
cd docker
docker-compose down -v
docker-compose up -d

# Local
cd apps/backend
pnpm prisma migrate reset  # Recreates database
pnpm db:seed               # Adds test data
```

---

## Verify Everything Works

### Frontend Test

1. Open http://localhost:3000
2. You should see a Next.js page (currently empty, we'll add UI)

### Backend Test

1. Open http://localhost:3001/health in browser
2. You should see: `{"status":"ok",...}`

### Database Test

```bash
# Local: pnpm db:studio
# Or check Docker logs:
docker-compose logs postgres
```

---

## What's Running?

### Services

| Service | URL | Purpose |
|---------|-----|---------|
| Frontend | http://localhost:3000 | React Next.js app |
| Backend | http://localhost:3001 | Express.js API |
| PostgreSQL | localhost:5432 | Database |
| n8n | http://localhost:5678 | Workflow automation |

### Tech Stack

- **Frontend**: Next.js 14, React 18, TypeScript, TailwindCSS
- **Backend**: Express.js, Node.js 20, TypeScript, Prisma ORM
- **Database**: PostgreSQL 15
- **Workflow**: n8n (for automation later)

---

## Troubleshooting

### "Port already in use"

```bash
# Find process using port
lsof -i :3000  # Frontend
lsof -i :3001  # Backend
lsof -i :5432  # Database

# Kill it
kill -9 <PID>
```

### "Cannot connect to database"

```bash
# Check if postgres container is running
docker-compose ps

# If not, start it
docker-compose up -d postgres

# Wait 10 seconds, then try again
```

### "Cannot find module" errors

```bash
# Reinstall dependencies
rm -rf node_modules pnpm-lock.yaml
pnpm install

# Or just clean cache
pnpm store prune
```

### Docker containers won't start

```bash
# Check logs
docker-compose logs

# Rebuild images
docker-compose build --no-cache

# Start fresh
docker-compose down -v
docker-compose up -d
```

---

## Next Steps

1. ✅ **Done**: Project is running!
2. 📖 **Read**: [ARCHITECTURE.md](./ARCHITECTURE.md) - Understand the structure
3. 🎯 **Explore**: Check out folders to see how code is organized
4. 💻 **Code**: Start building Phase 2 features:
   - GitHub OAuth integration
   - API endpoints
   - Frontend pages

---

## All Available Commands

### Root Commands

```bash
pnpm dev              # Start both frontend and backend
pnpm build            # Build both apps
pnpm lint             # Lint all code
pnpm format           # Format all code
pnpm docker:up        # Start Docker services
pnpm docker:down      # Stop Docker services
pnpm db:studio        # Open database UI
```

### Backend Commands

```bash
cd apps/backend

pnpm dev:watch        # Start with auto-reload
pnpm build            # Compile TypeScript
pnpm lint             # Lint code
pnpm format           # Format code
pnpm test             # Run tests
pnpm db:seed          # Seed database
pnpm db:studio        # Open database UI
pnpm prisma:generate  # Generate Prisma types
```

### Frontend Commands

```bash
cd apps/frontend

pnpm dev              # Start dev server
pnpm build            # Build for production
pnpm lint             # Lint code
pnpm format           # Format code
pnpm type-check       # Check TypeScript types
```

---

## Architecture Overview

```
OpenTrail (Monorepo)
├── apps/
│   ├── frontend/          # React Next.js app
│   │   └── src/
│   │       ├── app/       # Pages and routes
│   │       ├── components/# React components
│   │       └── lib/       # Utilities
│   │
│   └── backend/           # Express.js API
│       ├── src/
│       │   ├── routes/    # API routes
│       │   ├── services/  # Business logic
│       │   └── middleware/# Express middleware
│       └── prisma/        # Database schema
│
├── docker/                # Docker setup
├── workflows/             # n8n automation
└── docs/                  # Documentation
```

See [ARCHITECTURE.md](./ARCHITECTURE.md) for the complete guide.

---

## Getting Help

- **Issues**: Check terminal logs for errors
- **Questions**: Read [ARCHITECTURE.md](./ARCHITECTURE.md)
- **API Help**: See [docs/API.md](./docs/API.md)
- **Database Help**: See [docs/DATABASE.md](./docs/DATABASE.md)
- **Setup Help**: See [docs/SETUP.md](./docs/SETUP.md)

---

## Success! 🎉

You now have OpenTrail running locally with:
- ✅ Frontend (React + Next.js)
- ✅ Backend (Express.js + PostgreSQL)
- ✅ Database (Prisma + PostgreSQL)
- ✅ Automation (n8n)

### What's Next?

1. **Explore** the codebase structure
2. **Read** [ARCHITECTURE.md](./ARCHITECTURE.md)
3. **Build** Phase 2 features

Happy coding! 🚀
