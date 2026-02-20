---
mode: 'agent'
description: 'Workshop Lab 3: Generate comprehensive unit tests for untested API repositories'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages']
---

# 🧪 Lab 3: Test Coverage Blitz — Repository Unit Tests

## Context
This is a workshop lab for "Reducing Developer Toil." The API has 7 repository classes but only **1 test file** (`suppliersRepo.test.ts`). The other 6 repositories have zero test coverage. Writing tests is the #1 developer toil — repetitive, pattern-heavy, and often skipped.

## Current State
- ✅ `api/src/repositories/suppliersRepo.test.ts` — exists (use as reference pattern)
- ❌ `api/src/repositories/branchesRepo.ts` — no tests
- ❌ `api/src/repositories/productsRepo.ts` — no tests
- ❌ `api/src/repositories/ordersRepo.ts` — no tests
- ❌ `api/src/repositories/headquartersRepo.ts` — no tests
- ❌ `api/src/repositories/deliveriesRepo.ts` — no tests
- ❌ `api/src/repositories/orderDetailsRepo.ts` — no tests
- ❌ `api/src/repositories/orderDetailDeliveriesRepo.ts` — no tests

## Objective
Generate comprehensive unit tests for **at least 3** untested repositories, following the exact patterns in `suppliersRepo.test.ts`. Prioritize high-impact repos first.

## Priority Order
1. `productsRepo.ts` — most used entity, has `findBySupplierId`
2. `branchesRepo.ts` — has FK to headquarters
3. `ordersRepo.ts` — has FK to branches, status field

## Test Requirements

### Follow the existing pattern in `suppliersRepo.test.ts`:

1. **Setup:**
   ```typescript
   import { describe, it, expect, beforeEach, afterEach } from 'vitest';
   ```
   - Use in-memory SQLite database (`:memory:`)
   - Create tables in `beforeEach` using the migration SQL
   - Close database in `afterEach`

2. **CRUD coverage for each repository:**
   - `findAll()` — returns all records, returns empty array when no data
   - `findById(id)` — returns record when found, returns null when not found
   - `create(entity)` — inserts and returns new record with generated ID
   - `update(id, entity)` — updates existing record, throws for non-existent
   - `delete(id)` — removes record, throws for non-existent

3. **Specialized query tests:**
   - Test `findByName`, `findBySupplierId`, or other specialized methods
   - Test with FK constraints (create parent records first)

4. **Edge cases:**
   - Invalid IDs (negative, zero)
   - Duplicate unique fields
   - Null/undefined optional fields
   - Empty string values

5. **Error handling:**
   - Non-existent records throw `NotFoundError`
   - Database constraint violations are handled

### Test file naming
- `api/src/repositories/productsRepo.test.ts`
- `api/src/repositories/branchesRepo.test.ts`
- `api/src/repositories/ordersRepo.test.ts`

## References
- **Pattern file:** Study `api/src/repositories/suppliersRepo.test.ts` carefully before generating
- **Migration SQL:** Read `api/database/migrations/001_init.sql` for table schemas
- **Repo implementations:** Read each repo file to understand methods and types
- **Test config:** Check `api/vitest.config.ts` for test setup

## Self-Healing Instructions
After generating each test file:
1. Run `npm run test --workspace=api` or `npx vitest run`
2. If any tests fail, **analyze the error and fix the test**
3. Common issues to auto-fix:
   - Wrong column names (check migration SQL)
   - Missing parent records for FK constraints
   - Incorrect import paths
   - Boolean field handling differences
4. Re-run until all tests pass

## Validation
1. Run `npm run test --workspace=api` — ALL tests must pass
2. Run `npx vitest --coverage` if available — note coverage improvement
3. At least 15+ new test cases across the 3 files

## Success Criteria
- [ ] 3 new test files created
- [ ] All CRUD operations tested per repository
- [ ] Edge cases and error scenarios included
- [ ] All tests pass (zero failures)
- [ ] Self-healed at least one initial failure
