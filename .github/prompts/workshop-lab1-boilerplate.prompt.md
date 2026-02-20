---
mode: 'agent'
description: 'Workshop Lab 1: Generate a complete Warehouse API endpoint stack using the api-endpoint skill'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'githubRepo', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages']
---

# 🏗️ Lab 1: Kill the Boilerplate — Warehouse Entity Scaffolding

## Context
This is a workshop lab for "Reducing Developer Toil." You are working with the OctoCAT Supply Chain Management application — a TypeScript monorepo with an Express REST API and React frontend.

## Current State
- The API has 8 entities: suppliers, headquarters, branches, products, orders, order_details, deliveries, order_detail_deliveries
- Each entity follows a consistent pattern: Model → Repository → Route (with Swagger) → Migration → Seed data
- The **api-endpoint** skill in `.github/skills/api-endpoint/SKILL.md` defines the generation patterns

## Objective
Use the `api-endpoint` skill to generate a **complete** API endpoint stack for a new **Warehouse** entity. This demonstrates how Skills eliminate boilerplate toil.

## Entity Definition

**Warehouse** — represents a storage facility in the supply chain.

| Field | Type | Constraints |
|-------|------|------------|
| `warehouseId` | integer | Primary key, auto-increment |
| `name` | string | Required, max 100 chars |
| `location` | string | Required, max 200 chars |
| `capacity` | integer | Required, positive |
| `currentStock` | integer | Default 0 |
| `managerId` | integer | Nullable (FK to future employees) |
| `isActive` | boolean | Default true |

## Generation Requirements

### 1. Model (`api/src/models/warehouse.ts`)
- TypeScript interface matching field definitions
- Swagger `@swagger` JSDoc schema above the interface
- Follow naming conventions from existing models (e.g., `supplier.ts`)

### 2. Repository (`api/src/repositories/warehousesRepo.ts`)
- Class `WarehousesRepository` with constructor taking `DatabaseConnection`
- CRUD methods: `findAll`, `findById`, `create`, `update`, `delete`
- Additional: `findByName(name: string)` for search
- Use `buildInsertSQL`, `buildUpdateSQL`, `objectToCamelCase`, `mapDatabaseRows` from `utils/sql`
- Use `handleDatabaseError`, `NotFoundError` from `utils/errors`
- Include singleton factory function `getWarehousesRepository()`
- Handle boolean conversion for `isActive` (see `suppliersRepo.ts` pattern)

### 3. Route (`api/src/routes/warehouse.ts`)
- Express Router with full CRUD: GET all, GET by ID, POST, PUT, DELETE
- Swagger JSDoc for every endpoint (follow `supplier.ts` Swagger patterns)
- Use error middleware pattern (try/catch with `next(error)`)
- Tag: `Warehouses`

### 4. Migration (`api/database/migrations/003_warehouses.sql`)
- `CREATE TABLE IF NOT EXISTS warehouses` with snake_case columns
- Proper SQLite types and constraints
- `warehouse_id INTEGER PRIMARY KEY AUTOINCREMENT`

### 5. Seed Data (`api/database/seed/005_warehouses.sql`)
- 3–5 sample warehouses with cat-themed names (stay on brand!)
- Examples: "Whisker Distribution Center", "Purrfect Storage Hub"

### 6. Registration
- Import and register warehouse routes in `api/src/index.ts`
- Path: `/api/warehouses`

## References
- Read the skill at `.github/skills/api-endpoint/SKILL.md` for full patterns
- Study `api/src/models/supplier.ts`, `api/src/repositories/suppliersRepo.ts`, `api/src/routes/supplier.ts` as reference implementations
- Follow conventions in `.github/instructions/api.instructions.md`

## Validation
After generating all files:
1. Run `npm run build --workspace=api` to verify compilation
2. Fix any type errors or import issues
3. Confirm the Swagger docs render correctly

## Success Criteria
- [ ] All 5 files created following codebase patterns
- [ ] Route registered in `index.ts`
- [ ] Build passes without errors
- [ ] Swagger annotations are complete and valid
