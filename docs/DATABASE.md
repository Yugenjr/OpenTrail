# Database Schema

## Overview

OpenTrail uses PostgreSQL as its database with Prisma ORM for type-safe database access.

## Models

### User
Main user account model with GitHub integration.

```typescript
User {
  id: String (unique)
  email: String (unique)
  username: String (unique)
  password: String? (nullable for OAuth users)
  firstName: String?
  lastName: String?
  avatar: String?
  bio: String?
  role: UserRole (USER | ADMIN | MODERATOR)
  isActive: Boolean
  
  // GitHub integration
  githubId: String? (unique)
  githubUsername: String?
  githubToken: String?
  githubTokenExp: DateTime?
  
  // Relations
  contributions: Contribution[]
  savedRepositories: SavedRepository[]
  preferences: UserPreferences?
  
  timestamps: createdAt, updatedAt, lastLoginAt
}
```

### Repository
GitHub repositories indexed in the platform.

```typescript
Repository {
  id: String (unique)
  githubId: String (unique)
  name: String
  owner: String
  fullName: String (unique) e.g., "facebook/react"
  description: String?
  url: String
  homepage: String?
  
  // Stats
  stars: Int
  forks: Int
  watchers: Int
  openIssues: Int
  
  // Details
  language: RepositoryLanguage?
  languages: RepositoryLanguage[]
  topics: String[]
  isArchived: Boolean
  isFork: Boolean
  license: String?
  
  // Activity
  lastActivityAt: DateTime?
  pushedAt: DateTime?
  createdAt: DateTime
  
  // Relations
  opportunities: Opportunity[]
  savedBy: SavedRepository[]
  syncHistory: RepositorySyncHistory[]
}
```

### Opportunity
Open source opportunities (issues, PRs, discussions).

```typescript
Opportunity {
  id: String (unique)
  repositoryId: String (foreign key)
  githubIssueId: String
  
  title: String
  description: String?
  url: String
  
  type: ContributionType (PULL_REQUEST | ISSUE | DISCUSSION | CODE_REVIEW)
  difficulty: OpportunityDifficulty (BEGINNER | INTERMEDIATE | ADVANCED)
  tags: String[]
  
  // Tracking
  createdAt: DateTime
  updatedAt: DateTime
  fetchedAt: DateTime
  
  // Relations
  repository: Repository
  contributions: Contribution[]
}
```

### Contribution
Tracks user contributions to opportunities.

```typescript
Contribution {
  id: String (unique)
  userId: String (foreign key)
  opportunityId: String (foreign key)
  
  status: String (submitted | approved | merged | closed)
  link: String?
  notes: String?
  
  timestamps: createdAt, updatedAt
  
  // Relations
  user: User
  opportunity: Opportunity
}
```

### SavedRepository
User's bookmarked repositories.

```typescript
SavedRepository {
  id: String (unique)
  userId: String (foreign key)
  repositoryId: String (foreign key)
  
  savedAt: DateTime
  notes: String?
  
  // Composite unique constraint on (userId, repositoryId)
  // Relations
  user: User
  repository: Repository
}
```

### UserPreferences
User-specific settings and preferences.

```typescript
UserPreferences {
  id: String (unique)
  userId: String (unique, foreign key)
  
  emailNotifications: Boolean
  recommendationFrequency: String (daily | weekly | monthly)
  maxRecommendationsPerWeek: Int
  
  timestamps: createdAt, updatedAt
  
  // Relations
  user: User
}
```

### RepositorySyncHistory
Audit trail for repository data syncing.

```typescript
RepositorySyncHistory {
  id: String (unique)
  repositoryId: String (foreign key)
  
  syncedAt: DateTime
  status: String (success | failed)
  message: String?
  
  issuesCount: Int
  prsCount: Int
  
  // Relations
  repository: Repository
}
```

### AuditLog
Track all important actions for compliance.

```typescript
AuditLog {
  id: String (unique)
  userId: String?
  action: String
  resource: String
  resourceId: String?
  changes: Json?
  ipAddress: String?
  
  createdAt: DateTime
}
```

## Enums

```typescript
UserRole = USER | ADMIN | MODERATOR

ContributionType = PULL_REQUEST | ISSUE | DISCUSSION | CODE_REVIEW

RepositoryLanguage = TYPESCRIPT | JAVASCRIPT | PYTHON | JAVA | GO | RUST | CPP | CSHARP | PHP | RUBY | OTHER

OpportunityDifficulty = BEGINNER | INTERMEDIATE | ADVANCED
```

## Relationships

- **User → Contribution** (1:many) - User makes contributions
- **User → SavedRepository** (1:many) - User saves repositories
- **User → UserPreferences** (1:1) - User has preferences
- **Repository → Opportunity** (1:many) - Repository has opportunities
- **Repository → SavedRepository** (1:many) - Repository is saved by users
- **Repository → RepositorySyncHistory** (1:many) - Repository sync history
- **Opportunity → Contribution** (1:many) - Opportunity has contributions

## Indexes

For performance optimization:
- `User.email` - Unique, indexed
- `User.username` - Unique, indexed
- `User.githubUsername` - Indexed
- `Repository.fullName` - Unique, indexed
- `Repository.owner` - Indexed
- `Repository.language` - Indexed
- `Repository.lastActivityAt` - Indexed
- `Opportunity.repositoryId` - Indexed
- `Opportunity.type` - Indexed
- `Opportunity.difficulty` - Indexed
- `Opportunity.createdAt` - Indexed
- `Contribution.userId` - Indexed
- `Contribution.opportunityId` - Indexed
- `Contribution.status` - Indexed

See [ARCHITECTURE.md](../ARCHITECTURE.md) for the complete Prisma schema definition.
