# Contributing to OpenTrail

Thanks for your interest in contributing to OpenTrail! This document provides guidelines for contributing to the project.

## Code of Conduct

We are committed to providing a welcoming and inclusive environment for all contributors.

## How to Contribute

### 1. Fork the Repository

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/your-username/opentrail.git
cd opentrail
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or for bug fixes:
git checkout -b fix/your-bug-fix
```

### 3. Make Your Changes

- Follow the naming conventions in [ARCHITECTURE.md](./ARCHITECTURE.md)
- Write clear, descriptive commit messages
- Keep commits focused on a single issue

### 4. Code Quality Checks

Before committing:

```bash
# Format code
pnpm format

# Lint code
pnpm lint

# Type check
pnpm type-check

# Run tests
pnpm test
```

### 5. Create a Pull Request

- Push your branch: `git push origin feature/your-feature-name`
- Create PR with clear description
- Link related issues

## Development Guidelines

### TypeScript Best Practices

- Use strict mode (`strict: true`)
- Add proper type annotations
- Avoid `any` types
- Export types for public APIs

### Naming Conventions

See [ARCHITECTURE.md](./ARCHITECTURE.md) for detailed conventions:

- Controllers: `PascalCase + Controller`
- Services: `PascalCase + Service`
- Routes: `kebab-case`
- Types: `PascalCase`
- Variables: `camelCase`
- Constants: `UPPER_SNAKE_CASE`

### Project Structure

- Keep features modular
- One responsibility per file
- Clear separation of concerns
- Avoid circular imports

### Testing

- Write unit tests for business logic
- Write integration tests for APIs
- Aim for >80% code coverage
- Use descriptive test names

## Commit Message Format

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `style:` - Code style (formatting)
- `refactor:` - Code refactoring
- `perf:` - Performance improvement
- `test:` - Test changes

Examples:
```
feat(auth): add GitHub OAuth integration
fix(database): handle null values in user preferences
docs: update setup instructions
```

## Pull Request Process

1. Update documentation for new features
2. Add/update tests as needed
3. Ensure all checks pass:
   - TypeScript compilation
   - Linting
   - Tests
   - Code coverage
4. Get approval from maintainers
5. Merge to main branch

## Getting Help

- Check existing issues and discussions
- Ask questions in PRs
- Review [ARCHITECTURE.md](./ARCHITECTURE.md) for context
- Check [docs/](./docs/) folder for detailed info

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to OpenTrail! 🎉
