# API Documentation

Coming soon! This will document all OpenTrail API endpoints.

## Endpoints Overview

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `POST /api/auth/github/callback` - GitHub OAuth callback
- `POST /api/auth/logout` - User logout
- `GET /api/auth/me` - Get current user

### Users
- `GET /api/users/:id` - Get user profile
- `PUT /api/users/:id` - Update user profile
- `GET /api/users/:id/preferences` - Get user preferences
- `PUT /api/users/:id/preferences` - Update preferences

### Repositories
- `GET /api/repositories` - List repositories with filters
- `GET /api/repositories/:id` - Get repository details
- `POST /api/repositories/:id/save` - Save repository
- `DELETE /api/repositories/:id/save` - Unsave repository

### Opportunities
- `GET /api/opportunities` - List opportunities
- `GET /api/opportunities/:id` - Get opportunity details
- `POST /api/opportunities/:id/apply` - Apply to opportunity

### Contributions
- `GET /api/contributions` - List user contributions
- `POST /api/contributions` - Record new contribution
- `GET /api/contributions/:id` - Get contribution details

See [ARCHITECTURE.md](../ARCHITECTURE.md) for more details.
