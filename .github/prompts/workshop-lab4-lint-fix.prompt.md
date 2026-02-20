---
mode: 'agent'
description: 'Workshop Lab 4: Refactor duplicated patterns and add health check endpoint'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages']
---

# 🧹 Lab 4: Lint, Fix, Ship — Bulk Code Hygiene

## Context
This is a workshop lab for "Reducing Developer Toil." The API codebase has accumulated several code hygiene issues: duplicated error handling, no health check, and repeated `parseInt` + validation patterns across every route file. These are "easy wins" that pile up because no single one justifies its own PR.

## Current State
Examine the route files in `api/src/routes/` — you'll find:

1. **Repeated `parseInt` + NaN check** in every route handler:
   ```typescript
   const id = parseInt(req.params.id);
   // ... manually checked in each handler
   ```

2. **Duplicated `NotFoundError` pattern** — same try/catch + 404 pattern repeated in GET-by-ID, PUT, DELETE handlers across all 8 route files.

3. **No health check endpoint** — common requirement for deployment/monitoring.

4. **No request ID or logging middleware** — makes debugging production issues harder.

## Objective
Refactor the codebase to eliminate DRY violations and add essential infrastructure, without breaking existing tests.

## Tasks

### Task 1: Create `parseId()` utility

Create a shared utility function in `api/src/utils/routeHelpers.ts`:

```typescript
/**
 * Parses a route parameter as an integer ID.
 * @param param - The raw string from req.params
 * @returns The parsed integer
 * @throws {ValidationError} If the parameter is not a valid positive integer
 */
export function parseId(param: string): number {
  const id = parseInt(param, 10);
  if (isNaN(id) || id <= 0) {
    throw new ValidationError('Invalid ID parameter');
  }
  return id;
}
```

- Add `ValidationError` to `api/src/utils/errors.ts` if it doesn't exist
- Apply `parseId()` to at least the **supplier** and **product** route files as examples
- Ensure error middleware handles `ValidationError` with 400 status

### Task 2: Add Health Check Endpoint

Add to `api/src/index.ts`:

```typescript
app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    version: process.env.npm_package_version || '1.0.0'
  });
});
```

Include Swagger documentation for the health endpoint.

### Task 3: Create `asyncHandler()` wrapper (optional)

If time permits, create an async handler wrapper to eliminate try/catch boilerplate:

```typescript
export function asyncHandler(fn: (req: Request, res: Response, next: NextFunction) => Promise<void>) {
  return (req: Request, res: Response, next: NextFunction) => {
    fn(req, res, next).catch(next);
  };
}
```

Apply to at least one route file as a demonstration.

## Rules
- **Do not break existing tests** — run tests after each change
- Follow existing patterns in `api/src/utils/errors.ts`
- Keep the refactoring minimal and focused
- Update only supplier and product routes (demonstrate the pattern, not mass-refactor)

## Validation
1. Run `npm run build --workspace=api` — must compile
2. Run `npm run test --workspace=api` — all existing tests must pass
3. Test `GET /api/health` returns expected JSON
4. Test that invalid IDs return 400 instead of NaN-related errors

## Success Criteria
- [ ] `api/src/utils/routeHelpers.ts` exists with `parseId()`
- [ ] `parseId()` used in supplier and product routes
- [ ] `GET /api/health` returns `{ status: "ok", timestamp, uptime, version }`
- [ ] All existing tests pass
- [ ] Code review shows reduced duplication
