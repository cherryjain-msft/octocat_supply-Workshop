---
mode: 'agent'
description: 'Workshop Lab 2: Add JSDoc documentation to all API repository files'
tools: ['changes', 'codebase', 'editFiles', 'problems', 'search', 'usages']
---

# 📚 Lab 2: Docs That Write Themselves — Bulk Documentation

## Context
This is a workshop lab for "Reducing Developer Toil." The OctoCAT Supply Chain API has 7+ repository files with little or no JSDoc documentation. New developers waste time reading implementation code instead of API docs.

## Current State
- Most repository files in `api/src/repositories/` lack JSDoc on class methods
- Route files have Swagger annotations but inconsistent inline docs
- No `api/README.md` exists for project overview
- `.github/instructions/api.instructions.md` defines the expected documentation style

## Objective
Add comprehensive JSDoc documentation to ALL repository files without changing any logic. Then generate an `api/README.md` with architecture overview.

## Documentation Requirements

### Repository JSDoc (ALL files in `api/src/repositories/`)

For **each** repository file, add:

1. **Class-level JSDoc:**
   ```typescript
   /**
    * Repository for managing [entity] data access operations.
    * Provides CRUD methods and specialized queries for [entity] entities.
    *
    * @example
    * const repo = get[Entities]Repository();
    * const items = await repo.findAll();
    */
   ```

2. **Method-level JSDoc on every public method:**
   ```typescript
   /**
    * Retrieves all [entities] from the database.
    *
    * @returns {Promise<Entity[]>} Array of all [entity] records, ordered by ID
    * @throws {DatabaseError} If the database query fails
    *
    * @example
    * const items = await repo.findAll();
    * console.log(`Found ${items.length} records`);
    */
   ```

3. **Include for each method:**
   - `@param` with type and description for every parameter
   - `@returns` with type and description
   - `@throws` for error cases (NotFoundError, DatabaseError)
   - `@example` for non-trivial methods

### Target Files
- [ ] `api/src/repositories/suppliersRepo.ts`
- [ ] `api/src/repositories/branchesRepo.ts`
- [ ] `api/src/repositories/headquartersRepo.ts`
- [ ] `api/src/repositories/productsRepo.ts`
- [ ] `api/src/repositories/ordersRepo.ts`
- [ ] `api/src/repositories/orderDetailsRepo.ts`
- [ ] `api/src/repositories/deliveriesRepo.ts`
- [ ] `api/src/repositories/orderDetailDeliveriesRepo.ts`

### API README (`api/README.md`)

Generate a README with:
- Project description (OctoCAT Supply Chain API)
- Tech stack (Express, SQLite, TypeScript, Swagger)
- Quick start (install, build, run, test)
- Architecture overview (Routes → Repositories → SQLite)
- Available endpoints table (path, method, description)
- Environment variables
- Testing instructions

## Rules
- **DO NOT change any business logic or function signatures**
- **Only ADD documentation** — JSDoc comments, the README file
- Follow the documentation style in `.github/instructions/api.instructions.md`
- Read existing JSDoc patterns in `api/src/models/` for Swagger style reference

## Validation
1. Run `npm run build --workspace=api` to verify no compilation errors
2. Run `npm run test --workspace=api` to verify no test regressions

## Success Criteria
- [ ] All 8 repository files have JSDoc on every public method
- [ ] `api/README.md` exists and is comprehensive
- [ ] Zero logic changes — documentation only
- [ ] Build and tests pass
