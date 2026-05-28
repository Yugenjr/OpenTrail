# Frontend - OpenTrail Web Application

Next.js 14 + React frontend for OpenTrail platform.

## Quick Start

```bash
# Install dependencies
pnpm install

# Run in development
pnpm dev

# Open browser
# http://localhost:3000
```

## Scripts

- `pnpm dev` - Start development server
- `pnpm build` - Build for production
- `pnpm start` - Start production server
- `pnpm lint` - Lint TypeScript/React code
- `pnpm format` - Format code with Prettier
- `pnpm type-check` - Type check without build

## Environment Variables

See `.env.example` for all available variables.

Create `.env.local` with your settings:

```env
NEXT_PUBLIC_API_URL=http://localhost:3001
NEXT_PUBLIC_API_BASE=/api
NEXT_PUBLIC_ENV=development
```

## Folder Structure

```
src/
├── app/              # Next.js App Router
│   ├── (auth)/       # Auth route group
│   ├── (dashboard)/  # Protected routes
│   ├── layout.tsx    # Root layout
│   └── page.tsx      # Home page
├── components/       # Reusable components
│   ├── ui/           # shadcn/ui components
│   ├── auth/         # Auth components
│   ├── dashboard/    # Dashboard components
│   └── common/       # Shared components
├── hooks/            # Custom React hooks
├── lib/              # Utility functions
│   ├── api.ts        # API client setup
│   └── utils.ts      # Helpers
├── store/            # Zustand stores
├── types/            # TypeScript types
└── styles/           # Global styles

public/              # Static files
```

## Development Workflow

1. Create pages in `src/app/`
2. Create components in `src/components/`
3. Use `@/` alias to import from src
4. Server auto-reloads on file save
5. Hot Module Replacement (HMR) for instant updates

## Component Example

```typescript
// src/components/Button.tsx
import { ComponentProps } from 'react';

export function Button({ children, ...props }: ComponentProps<'button'>) {
  return (
    <button className="px-4 py-2 bg-blue-600 text-white rounded" {...props}>
      {children}
    </button>
  );
}
```

## Using shadcn/ui Components

```bash
# Add component (e.g., Button)
pnpm dlx shadcn-ui@latest add button

# Use in your code
import { Button } from '@/components/ui/button';
```

## API Integration

```typescript
// src/lib/api.ts
import axios from 'axios';

export const api = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
});
```

## State Management (Zustand)

```typescript
// src/store/userStore.ts
import { create } from 'zustand';

export const useUserStore = create((set) => ({
  user: null,
  setUser: (user) => set({ user }),
}));
```

## Type Safety

Always define types for API responses:

```typescript
// src/types/user.ts
export interface User {
  id: string;
  email: string;
  username: string;
  role: 'user' | 'admin';
}
```

See [../../ARCHITECTURE.md](../../ARCHITECTURE.md) for detailed architecture information.
