# OpenTrail - Architecture & Setup Guide

**OpenTrail** is an OSS contribution intelligence platform that helps developers discover active open-source repositories, recommends contribution opportunities, and provides AI-powered guidance.

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Technology Stack](#technology-stack)
3. [Monorepo Folder Structure](#monorepo-folder-structure)
4. [Architecture Principles](#architecture-principles)
5. [Step-by-Step Setup](#step-by-step-setup)
6. [Frontend Setup](#frontend-setup)
7. [Backend Setup](#backend-setup)
8. [Database Setup (Prisma)](#database-setup-prisma)
9. [Docker Configuration](#docker-configuration)
10. [Development Workflow](#development-workflow)

---

## Project Overview

**Goal**: Build an intelligent platform that:
- Analyzes GitHub profiles and tech stacks
- Discovers active OSS repositories matching user interests
- Recommends contribution opportunities
- Summarizes issues and PRs with AI
- Guides developers through contribution processes
- Tracks contributions and impact

**Phase 1 (Current)**: Architecture, folder structure, Docker setup, API skeleton
**Phase 2**: GitHub OAuth integration
**Phase 3**: AI-powered features

---

## Technology Stack

### Frontend
- **Next.js 14+** (App Router) - React framework with SSR/SSG
- **TypeScript** - Type-safe JavaScript
- **TailwindCSS** - Utility-first CSS
- **shadcn/ui** - Accessible component library
- **Zustand/React Context** - State management
- **React Query/SWR** - Server state management
- **Axios** - HTTP client

### Backend
- **Node.js 20+** - JavaScript runtime
- **Express.js** - Lightweight web framework
- **TypeScript** - Type safety
- **Prisma ORM** - Database abstraction layer
- **PostgreSQL** - Relational database
- **JWT** - Authentication
- **Zod/Joi** - Request validation
- **Winston/Pino** - Logging

### Database
- **PostgreSQL 15+** - Primary data store
- **Prisma Client** - ORM for type-safe database access
- **Prisma Migrations** - Version control for schemas

### Automation & Workflows
- **n8n** - Workflow automation (Dockerized)
- Scheduled jobs for repository indexing
- GitHub data sync workflows

### Infrastructure
- **Docker** - Containerization
- **Docker Compose** - Multi-container orchestration
- **Environment variables** - Configuration management

---

## Monorepo Folder Structure

```
OpenTrail/
├── apps/
│   ├── frontend/                    # Next.js application
│   │   ├── src/
│   │   │   ├── app/                 # Next.js App Router
│   │   │   │   ├── (auth)/          # Auth route group
│   │   │   │   ├── (dashboard)/     # Protected routes group
│   │   │   │   ├── layout.tsx
│   │   │   │   ├── page.tsx         # Home page
│   │   │   │   └── error.tsx
│   │   │   ├── components/          # Reusable React components
│   │   │   │   ├── ui/              # shadcn/ui components
│   │   │   │   ├── auth/            # Auth-related components
│   │   │   │   ├── dashboard/       # Dashboard components
│   │   │   │   └── common/          # Shared components
│   │   │   ├── hooks/               # Custom React hooks
│   │   │   ├── lib/                 # Utility functions
│   │   │   │   ├── api.ts           # API client setup
│   │   │   │   ├── auth.ts          # Auth utilities
│   │   │   │   └── utils.ts         # Helpers
│   │   │   ├── store/               # Zustand stores
│   │   │   ├── types/               # TypeScript types
│   │   │   ├── styles/              # Global styles
│   │   │   ├── middleware.ts        # Next.js middleware
│   │   │   └── env.ts               # Environment validation
│   │   ├── public/                  # Static files
│   │   ├── .env.local               # Environment variables (local)
│   │   ├── .env.example             # Example environment variables
│   │   ├── tsconfig.json
│   │   ├── tailwind.config.ts
│   │   ├── next.config.js
│   │   ├── package.json
│   │   └── README.md
│   │
│   └── backend/                     # Express.js API server
│       ├── src/
│       │   ├── main.ts              # Application entry point
│       │   ├── server.ts            # Express server setup
│       │   ├── config/              # Configuration files
│       │   │   ├── database.ts      # Database configuration
│       │   │   ├── env.ts           # Environment validation
│       │   │   └── logger.ts        # Logger setup
│       │   ├── routes/              # API routes
│       │   │   ├── index.ts         # Route aggregator
│       │   │   ├── auth.ts          # Authentication routes
│       │   │   ├── users.ts         # User routes
│       │   │   ├── repositories.ts  # Repository routes
│       │   │   └── opportunities.ts # Opportunities routes
│       │   ├── controllers/         # Route handlers
│       │   │   ├── authController.ts
│       │   │   ├── userController.ts
│       │   │   ├── repositoryController.ts
│       │   │   └── opportunityController.ts
│       │   ├── services/            # Business logic
│       │   │   ├── authService.ts
│       │   │   ├── userService.ts
│       │   │   ├── repositoryService.ts
│       │   │   └── opportunityService.ts
│       │   ├── middleware/          # Express middleware
│       │   │   ├── errorHandler.ts
│       │   │   ├── auth.ts
│       │   │   ├── validation.ts
│       │   │   └── logger.ts
│       │   ├── utils/               # Utility functions
│       │   │   ├── responses.ts     # API response helpers
│       │   │   ├── errors.ts        # Error handling
│       │   │   └── helpers.ts
│       │   ├── types/               # TypeScript types/interfaces
│       │   │   ├── user.ts
│       │   │   ├── repository.ts
│       │   │   ├── opportunity.ts
│       │   │   └── common.ts
│       │   └── validators/          # Input validation schemas
│       │       ├── auth.ts
│       │       ├── user.ts
│       │       └── repository.ts
│       ├── prisma/                  # Database schema & migrations
│       │   ├── schema.prisma        # Data model
│       │   └── migrations/          # Migration history
│       ├── tests/                   # Test files
│       │   ├── unit/
│       │   └── integration/
│       ├── .env.local               # Environment variables (local)
│       ├── .env.example             # Example environment variables
│       ├── tsconfig.json
│       ├── package.json
│       ├── eslint.config.js
│       └── README.md
│
├── docker/                          # Docker configurations
│   ├── docker-compose.yml           # Main orchestration file
│   ├── docker-compose.prod.yml      # Production overrides
│   ├── frontend.dockerfile          # Frontend container
│   ├── backend.dockerfile           # Backend container
│   └── n8n/
│       └── docker-compose.yml       # n8n setup
│
├── workflows/                       # n8n workflow files
│   ├── sync-github-repos.json
│   ├── analyze-user-profile.json
│   └── find-opportunities.json
│
├── scripts/                         # Setup and utility scripts
│   ├── setup.sh                     # Initial setup script
│   ├── seed-db.ts                   # Database seeding
│   └── generate-types.sh            # Type generation
│
├── .github/                         # GitHub configuration
│   └── workflows/                   # CI/CD pipelines
│       └── ci.yml
│
├── docs/                            # Documentation
│   ├── ARCHITECTURE.md
│   ├── API.md
│   ├── DATABASE.md
│   └── SETUP.md
│
├── .gitignore
├── .env.example
├── package.json                     # Root package.json (for monorepo)
├── pnpm-workspace.yaml              # pnpm workspace config (recommended)
├── README.md                        # Main project README
├── CONTRIBUTING.md
└── LICENSE

```

### Folder Structure Explanation

**apps/** - Contains all application code (frontend & backend), monorepo structure allows shared types and utilities

**apps/frontend/** - Next.js 14+ with App Router, route groups for organized navigation, components organized by feature/domain, state management with Zustand

**apps/backend/** - Express.js REST API with clean architecture (Controllers → Services → Prisma)

**prisma/** - Database schema and migrations as version control

**docker/** - Centralized Docker configurations for dev and production

**workflows/** - n8n workflow JSON files for automation

**scripts/** - Utility scripts for setup, seeding, code generation

---

## Architecture Principles

### 1. **Clean Architecture**
- **Controllers** receive HTTP requests
- **Services** contain business logic (reusable, testable)
- **Repositories** handle data access (through Prisma)
- **Middleware** handles cross-cutting concerns

### 2. **Separation of Concerns**
- Frontend: UI, state, client-side logic
- Backend: API, business logic, database
- Database: Prisma manages all data access

### 3. **Type Safety**
- TypeScript everywhere (frontend + backend)
- Shared types for API contracts
- Zod/Joi for runtime validation

### 4. **Modularity**
- Feature-based folder structure
- Clear dependencies (no circular imports)
- Easy to add new features

### 5. **Scalability**
- Environment-based configuration
- Docker for consistent deployments
- Database migrations for version control
- API versioning ready

### 6. **Developer Experience**
- Hot reload in development (Next.js, nodemon)
- Consistent formatting (Prettier)
- Linting (ESLint)
- Type checking (TypeScript)

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Controllers | PascalCase + "Controller" | `UserController` |
| Services | PascalCase + "Service" | `UserService` |
| Routes | kebab-case | `/api/users`, `/api/repositories` |
| Types | PascalCase | `User`, `Repository` |
| Interfaces | PascalCase + "I" prefix | `IUserService` |
| Constants | UPPER_SNAKE_CASE | `MAX_FILE_SIZE` |
| Variables | camelCase | `userName`, `isActive` |
| Folders | kebab-case | `user-service`, `api-routes` |
| Files | camelCase or PascalCase | `userService.ts`, `User.ts` |

---

## Key Design Decisions

### Why Monorepo?
- Shared types between frontend and backend
- Single source of truth for dependencies
- Easier to refactor across apps
- Simplified CI/CD configuration

### Why Prisma?
- Type-safe database access
- Automatic migrations
- Database studio for quick prototyping
- Great developer experience

### Why Express.js?
- Lightweight and flexible
- Large ecosystem
- Easy to add middleware
- Perfect for microservices architecture

### Why Next.js 14 with App Router?
- Modern React features
- Built-in API routes
- Built-in SSR/SSG
- Excellent performance

### Why Docker Compose?
- Local development mirrors production
- Consistent environments
- Easy onboarding for new developers
- Simplifies infrastructure setup

---

## Next Steps (Phase 2)

1. **GitHub OAuth Integration**
   - Implement GitHub login flow
   - Fetch user profile data
   - Store GitHub tokens securely

2. **API Endpoints**
   - Create CRUD endpoints for all models
   - Implement pagination and filtering
   - Add input validation

3. **Frontend Pages**
   - Dashboard
   - Repository discovery
   - Opportunity recommendations
   - User profile

4. **n8n Workflows**
   - GitHub data sync
   - Repository indexing
   - Issue fetching

5. **AI Integration** (Phase 3)
   - Issue summarization
   - Recommendation engine
   - Contribution guidance

---

This architecture is:
✅ **Scalable** - Easy to add new features
✅ **Maintainable** - Clear structure and separation
✅ **Type-safe** - Full TypeScript coverage
✅ **Production-ready** - Docker, environment configs, logging
✅ **Developer-friendly** - Hot reload, clear tooling
✅ **AI-ready** - Extensible for future AI features
