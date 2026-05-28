# OpenTrail 🚀

An OSS contribution intelligence platform that helps developers discover active open-source repositories, recommends contribution opportunities, and provides AI-powered guidance.

**Live Intelligence + Contributor Onboarding = Better Open Source**

## 📖 Quick Navigation

- **[Full Architecture Guide](./ARCHITECTURE.md)** - Complete folder structure, design decisions, and principles
- **[Setup Instructions](#-quick-start)** - Get up and running in 10 minutes
- **[Development Commands](#-development-commands)** - All terminal commands you'll need
- **[API Documentation](./docs/API.md)** - Backend API reference
- **[Database Schema](./docs/DATABASE.md)** - Prisma models and relationships

---

## 🎯 What is OpenTrail?

OpenTrail is building a platform where:

1. **Developers login with GitHub** → System analyzes their profile
2. **System understands their skills** → Learns their tech stack and interests
3. **Smart matching happens** → Finds active repos they can contribute to
4. **Issues are summarized** → AI explains what needs to be done
5. **Guidance is provided** → Step-by-step contribution help
6. **Impact is tracked** → Record contributions and growth

### Phase 1 (Current)
✅ Architecture and project setup
✅ Folder structure with clean code practices
✅ Docker containerization
✅ Database schema (Prisma)
✅ API skeleton (Express)
✅ Frontend skeleton (Next.js)

### Phase 2 (Next)
⏳ GitHub OAuth integration
⏳ CRUD API endpoints
⏳ Frontend pages and components
⏳ n8n workflow automation

### Phase 3 (Future)
⏳ AI issue summaries
⏳ Contribution recommendations
⏳ Contribution guidance

---

## 🛠️ Quick Start

### Prerequisites

Make sure you have installed:
- **Node.js 20+** ([download](https://nodejs.org))
- **Docker & Docker Compose** ([download](https://www.docker.com/products/docker-desktop))
- **Git** ([download](https://git-scm.com))
- **pnpm** (recommended): `npm install -g pnpm` or use npm

### Option A: Docker Setup (Recommended for beginners)

Fastest way to get everything running:

```bash
# 1. Clone the repo (or navigate to existing project)
cd ~/Downloads/OpenTrail

# 2. Start all services
cd docker
docker-compose up -d

# 3. Wait for services to be healthy (check logs)
docker-compose logs -f

# 4. Services will be running at:
# Frontend: http://localhost:3000
# Backend: http://localhost:3001
# Database: localhost:5432
# n8n: http://localhost:5678
```

Access the applications:
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:3001
- **Backend Health**: http://localhost:3001/health
- **n8n**: http://localhost:5678 (username: admin, password: admin123)
- **Prisma Studio**: Run `cd apps/backend && pnpm db:studio`

### Option B: Local Development Setup

For active development with hot reload:

```bash
# 1. Navigate to project
cd ~/Downloads/OpenTrail

# 2. Install dependencies
pnpm install

# 3. Setup backend
cd apps/backend
pnpm prisma migrate dev --name init  # Create initial migration
pnpm db:seed                          # Seed test data

# 4. Start services (in separate terminals)

# Terminal 1: Backend
cd apps/backend
pnpm dev:watch

# Terminal 2: Frontend  
cd apps/frontend
pnpm dev

# Terminal 3: Database (optional)
cd apps/backend
pnpm db:studio
```

---

## 📁 Project Structure

```
OpenTrail/
├── apps/
│   ├── frontend/          Next.js 14+ app (React)
│   └── backend/           Express.js API server
├── docker/                Docker & Docker Compose configs
├── workflows/             n8n automation workflows
├── scripts/               Utility scripts
├── docs/                  Documentation
├── ARCHITECTURE.md        Detailed architecture guide
├── README.md             This file
└── pnpm-workspace.yaml   Monorepo config
```

See [ARCHITECTURE.md](./ARCHITECTURE.md) for detailed folder breakdown.

---

## 🚀 Development Commands

### Installation & Setup

```bash
# Install all dependencies
pnpm install

# Setup frontend
cd apps/frontend
pnpm install

# Setup backend
cd apps/backend
pnpm install
pnpm prisma migrate dev --name init
pnpm db:seed
```

### Development Mode

```bash
# Backend development (with watch/hot reload)
cd apps/backend
pnpm dev:watch

# Frontend development (with hot reload)
cd apps/frontend
pnpm dev

# Database studio (visual database editor)
cd apps/backend
pnpm db:studio

# Both frontend and backend (from root, requires 2 terminals)
pnpm dev
```

### Database Management

```bash
cd apps/backend

# Create new migration after schema changes
pnpm prisma migrate dev --name <migration_name>

# Push schema directly to database (for dev)
pnpm db:push

# Reset database (⚠️ deletes all data)
pnpm prisma migrate reset

# Generate Prisma client
pnpm prisma generate

# View database in UI
pnpm db:studio
```

### Code Quality

```bash
# Lint all code
pnpm lint

# Type check TypeScript
pnpm type-check

# Format code (Prettier)
pnpm format

# Run all checks
pnpm lint && pnpm type-check && pnpm format
```

### Testing

```bash
# Run tests once
pnpm test

# Run tests in watch mode
pnpm test:watch

# Run tests with coverage
pnpm test:coverage
```

### Building & Production

```bash
# Build for production
pnpm build

# Start production build
pnpm start

# Build Docker images
cd docker
docker-compose build

# Run production Docker setup
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

### Docker Commands

```bash
# Start services
cd docker
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f              # All services
docker-compose logs -f backend      # Just backend
docker-compose logs -f frontend     # Just frontend

# Restart service
docker-compose restart backend

# Remove volumes (⚠️ deletes data)
docker-compose down -v

# Build images
docker-compose build

# Check service status
docker-compose ps
```

---

## 🔧 Environment Configuration

### Backend Configuration

Create `apps/backend/.env.local`:

```env
# Server
NODE_ENV=development
PORT=3001
HOST=localhost

# Database
DATABASE_URL=postgresql://postgres:opentrail_password@localhost:5432/opentrail_db

# JWT
JWT_SECRET=dev_secret_key_change_in_production
JWT_EXPIRATION=7d

# GitHub (setup later)
GITHUB_API_TOKEN=your_token
GITHUB_CLIENT_ID=your_id
GITHUB_CLIENT_SECRET=your_secret

# Frontend
FRONTEND_URL=http://localhost:3000

# n8n
N8N_URL=http://localhost:5678
N8N_API_KEY=dev_key

# Logging
LOG_LEVEL=debug
```

### Frontend Configuration

Create `apps/frontend/.env.local`:

```env
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXT_PUBLIC_API_BASE=/api
NEXT_PUBLIC_GITHUB_CLIENT_ID=your_github_client_id
NEXT_PUBLIC_ENV=development
```

---

## 📊 Technology Stack

### Frontend
- **Next.js 14** - React framework with App Router
- **TypeScript** - Type-safe JavaScript
- **TailwindCSS** - Utility-first CSS
- **shadcn/ui** - Accessible component library
- **Zustand** - State management
- **React Query** - Server state management
- **Axios** - HTTP client

### Backend
- **Node.js 20** - JavaScript runtime
- **Express.js** - Web framework
- **TypeScript** - Type safety
- **Prisma ORM** - Database layer
- **PostgreSQL** - Database
- **JWT** - Authentication
- **Winston** - Logging

### Infrastructure
- **Docker** - Containerization
- **Docker Compose** - Orchestration
- **PostgreSQL 15** - Database
- **n8n** - Workflow automation

---

## 🗄️ Database Schema

The database includes models for:

- **User** - User profiles and preferences
- **Repository** - GitHub repositories
- **Opportunity** - Issues/PRs to contribute to
- **Contribution** - User contributions tracked
- **SavedRepository** - Bookmarked repos
- **RepositorySyncHistory** - Sync logs

See [ARCHITECTURE.md](./ARCHITECTURE.md) for full Prisma schema.

---

## 🔐 Security Notes

Current Phase 1 is for development only. Before production:

- [ ] Change `JWT_SECRET` to a strong random value
- [ ] Set secure PostgreSQL credentials
- [ ] Enable HTTPS
- [ ] Setup rate limiting
- [ ] Configure CORS properly
- [ ] Enable request validation
- [ ] Setup logging and monitoring
- [ ] Configure GitHub OAuth credentials
- [ ] Setup environment variable encryption

---

## 📚 Documentation

- **[ARCHITECTURE.md](./ARCHITECTURE.md)** - Full architecture guide, folder structure, design decisions
- **[docs/API.md](./docs/API.md)** - API endpoint documentation (coming soon)
- **[docs/DATABASE.md](./docs/DATABASE.md)** - Database schema and relationships (coming soon)
- **[docs/SETUP.md](./docs/SETUP.md)** - Detailed setup guide (coming soon)
- **[CONTRIBUTING.md](./CONTRIBUTING.md)** - Contribution guidelines (coming soon)

---

## 🎓 Learning Path

1. **Start here**: Read [ARCHITECTURE.md](./ARCHITECTURE.md)
2. **Setup**: Follow [Quick Start](#-quick-start)
3. **Explore**: Browse folder structure
4. **Understand**: Review database schema
5. **Code**: Start with Phase 2 tasks

---

## 🚀 Next Phase (Setup for Development)

### What to build next:

1. **GitHub OAuth** - User login
2. **API Endpoints** - CRUD operations
3. **Frontend Pages** - UI components
4. **n8n Workflows** - Automation
5. **AI Features** - Smart recommendations

---

## 💡 Pro Tips

### Local Development Workflow

```bash
# Terminal 1: Backend
cd ~/Downloads/OpenTrail/apps/backend
pnpm dev:watch

# Terminal 2: Frontend
cd ~/Downloads/OpenTrail/apps/frontend
pnpm dev

# Terminal 3: Database UI
cd ~/Downloads/OpenTrail/apps/backend
pnpm db:studio
```

### Making Schema Changes

```bash
# 1. Edit schema.prisma
# 2. Create migration
pnpm prisma migrate dev --name describe_change

# 3. Restart backend server
```

### Debugging

```bash
# View backend logs
cd docker
docker-compose logs -f backend

# View database
pnpm db:studio

# Check API
curl http://localhost:3001/health
```

---

## 🤝 Contributing

We're building this in the open! See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

---

## 📝 License

MIT License - See [LICENSE](./LICENSE) file for details.

---

## 🆘 Troubleshooting

### Services won't start
```bash
# Check if ports are in use
lsof -i :3000  # Frontend
lsof -i :3001  # Backend
lsof -i :5432  # Database

# Kill process using port
kill -9 <PID>
```

### Database connection fails
```bash
# Check Docker containers
docker-compose ps

# Restart database
docker-compose restart postgres

# Reset database (⚠️ deletes data)
docker-compose down -v
docker-compose up -d
```

### Node modules issues
```bash
# Clear and reinstall
rm -rf node_modules
pnpm install

# Clear pnpm cache
pnpm store prune
```

---

## 📞 Getting Help

- Check existing docs in `/docs`
- Review error logs in terminal output
- Check Docker logs: `docker-compose logs`
- Ask in discussions or issues

---

**Ready to contribute?** See [ARCHITECTURE.md](./ARCHITECTURE.md) to understand the codebase structure!

**Questions?** Check the docs folder or open an issue.

Happy coding! 🎉    