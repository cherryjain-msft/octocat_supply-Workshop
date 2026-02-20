---
mode: 'agent'
description: 'Workshop Lab 6: Create parallel Coding Agent sessions to evaluate different API service layer approaches'
tools: ['changes', 'codebase', 'fetch', 'githubRepo', 'problems', 'search', 'searchResults', 'usages', 'add_sub_issue', 'assign_copilot_to_issue', 'create_issue', 'get_issue', 'list_issues', 'list_sub_issues', 'search_issues', 'update_issue', 'github']
---

# ⚡ Lab 6: Agent HQ — Parallel Tech Debt Elimination

## Context
This is a workshop lab for "Reducing Developer Toil." The goal is to demonstrate Agent HQ's parallelism — running multiple Coding Agent sessions simultaneously to evaluate different technical approaches. Instead of one developer spending days prototyping alternatives, Copilot explores all paths at once.

## Current State
The frontend at `frontend/src/api/config.ts` has only a base URL configuration — no typed API service layer. Each component makes raw `axios` calls directly. This is a tech debt item the team has been debating: what's the best approach?

## Objective
Create an Epic issue with 3 sub-issues, each implementing a different API service layer approach. Assign all 3 to Coding Agent simultaneously. Compare the results.

## Instructions

### Step 1: Create the Epic Issue

```markdown
Title: Frontend API Service Layer — Evaluate 3 Approaches

## Description
The frontend currently has no API service abstraction layer. Components make direct
axios calls with no type safety, error handling, or caching strategy.

We need to evaluate approaches before committing to one. This epic launches 3 parallel
experiments via Coding Agent.

## Success Criteria
- 3 PRs with different implementations
- Each updates the Products page as proof-of-concept
- Comparison summary to inform team decision

Labels: `enhancement`, `workshop`, `tech-debt`
```

### Step 2: Create 3 Sub-Issues

**Approach A: Axios Service Modules**

```markdown
Title: [Experiment A] API Service Layer — Typed Axios Wrappers

## Description
Create a service layer using axios with TypeScript generics.

## Requirements
- Create `frontend/src/api/services/` directory
- Create `baseService.ts` — generic CRUD functions with error interceptors and retry
- Create `productService.ts` — typed methods: `getAll()`, `getById()`, `create()`, `update()`, `delete()`
- Create `supplierService.ts` — same pattern
- Update `frontend/src/components/entity/product/Products.tsx` to use the new service
- Add proper TypeScript types for all request/response payloads
- Add error handling with user-friendly error messages

## DO NOT change the API backend — only frontend changes.

## Acceptance Criteria
- [ ] Products page works with the new service layer
- [ ] Type safety: no `any` types
- [ ] Error states handled gracefully
- [ ] Build passes: `npm run build --workspace=frontend`
```

**Approach B: React Query Custom Hooks**

```markdown
Title: [Experiment B] API Service Layer — React Query Hooks

## Description
Create a service layer using @tanstack/react-query custom hooks.

## Requirements
- Verify `@tanstack/react-query` is installed (it should be)
- Create `frontend/src/api/hooks/` directory
- Create `useProducts.ts` — hooks: `useProducts()`, `useProduct(id)`, `useCreateProduct()`, `useUpdateProduct()`, `useDeleteProduct()`
- Create `useSuppliers.ts` — same pattern
- Use proper query keys, cache invalidation, and stale times
- Add optimistic updates for mutations
- Update `frontend/src/components/entity/product/Products.tsx` to use the hooks
- Add loading and error states in the UI

## DO NOT change the API backend — only frontend changes.

## Acceptance Criteria
- [ ] Products page works with React Query hooks
- [ ] Data is cached and invalidated correctly
- [ ] Loading/error states visible in UI
- [ ] Build passes: `npm run build --workspace=frontend`
```

**Approach C: OpenAPI Generated Client**

```markdown
Title: [Experiment C] API Service Layer — OpenAPI Generated Client

## Description
Auto-generate a typed API client from the existing Swagger spec.

## Requirements
- Use `api/api-swagger.json` as the source spec
- Install `openapi-typescript-codegen` or `openapi-fetch` + `openapi-typescript`
- Add a `generate:api` script to `frontend/package.json`
- Generate typed client in `frontend/src/api/generated/`
- Update `frontend/src/components/entity/product/Products.tsx` to use the generated client
- Document how to regenerate when the API spec changes

## DO NOT change the API backend — only frontend changes.

## Acceptance Criteria
- [ ] Generated client exists in `frontend/src/api/generated/`
- [ ] Products page works with the generated client
- [ ] Generation script reproducible via `npm run generate:api`
- [ ] Build passes: `npm run build --workspace=frontend`
```

### Step 3: Assign All 3 to Coding Agent

Assign Copilot as the assignee on all 3 sub-issues. They will run in parallel.

### Step 4: Provide Summary

After creating all issues, provide:
- Link to the Epic issue
- Links to all 3 sub-issues
- Confirmation all are assigned to Copilot
- Estimated completion time (usually 15-30 min per session)
- Instructions to monitor in Agent HQ

## Success Criteria
- [ ] Epic issue created with 3 sub-issues
- [ ] All 3 sub-issues assigned to Copilot Coding Agent
- [ ] Summary with links and monitoring instructions provided
