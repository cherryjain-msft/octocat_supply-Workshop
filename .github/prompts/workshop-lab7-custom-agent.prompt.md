---
mode: 'agent'
description: 'Workshop Lab 7: Build a full-stack Suppliers page using TDD custom agents'
tools: ['changes', 'codebase', 'editFiles', 'fetch', 'findTestFiles', 'githubRepo', 'openSimpleBrowser', 'problems', 'runCommands', 'runTasks', 'search', 'terminalLastCommand', 'testFailure', 'usages', 'playwright', 'github', 'assign_copilot_to_issue', 'create_issue']
---

# 🚀 Lab 7: Custom Agent — Full-Stack Feature with Agentic Workflow

## Context
This is a workshop lab for "Reducing Developer Toil." The goal is to demonstrate how custom agents (`.github/agents/`) orchestrate an end-to-end feature development workflow. You'll use the TDD agent chain (`tdd-planner` → `tdd-red` → `tdd-green`) and domain agents (`api-specialist`) to build a complete Suppliers Management page.

## Current State
- The API already has full CRUD endpoints for Suppliers at `/api/suppliers`
- The frontend has NO Suppliers page — only Products, Cart, and Admin Products exist
- The backend supports `isActive` and `isVerified` status fields (added in migration 002)
- No frontend API service layer exists (this is fine — build it inline for this feature)

## Objective
Build a complete Suppliers Management page on the frontend using the TDD agent workflow.

## Feature Requirements

### Suppliers List Page (`/suppliers`)
- Table/card view showing all suppliers
- Columns: Name, Contact Email, Phone, Status (Active/Verified badges), Product Count
- Search bar: filter by supplier name (client-side)
- Status filter: All / Active / Verified / Inactive
- Click row to navigate to detail view
- Responsive design using Tailwind CSS
- Loading and error states

### Supplier Detail View (`/suppliers/:id`)
- Full supplier information display
- List of products supplied by this supplier (use `/api/products?supplierId=X` or fetch all + filter)
- Toggle Active/Verified status (for admin users)
- Back navigation to list

### Navigation
- Add "Suppliers" link to the Navigation component
- Place it between "Products" and "Cart" (or in a logical position)

## Implementation Workflow

### Phase 1: Plan with `@tdd-planner`
Use the TDD Planner agent to analyze requirements and create a test plan:

```
@tdd-planner Plan a Suppliers Management page for the frontend.

Requirements:
- List all suppliers with name, status (active/verified badges), product count
- Search/filter by name and status
- Click supplier to see detail view with their products
- Admin can toggle active/verified status
- Uses the existing /api/suppliers endpoints
- Follows existing frontend patterns (React + Tailwind + React Query)
- Route: /suppliers for list, /suppliers/:id for detail
```

The planner will produce a structured plan WITHOUT writing code.

### Phase 2: Red Tests with `@tdd-red`
Hand off the plan to the TDD Red agent to write failing tests:

```
@tdd-red Implement the failing tests for this plan
```

Expected test files:
- `frontend/src/components/entity/supplier/Suppliers.test.tsx`
- `frontend/src/components/entity/supplier/SupplierDetail.test.tsx`

Tests should cover:
- Component rendering
- Data fetching and display
- Search/filter functionality
- Navigation between list and detail
- Status toggle (admin)
- Loading and error states

### Phase 3: Green Implementation with `@tdd-green`
Hand off the failing tests to the TDD Green agent:

```
@tdd-green Make all the failing Supplier tests pass
```

Expected implementation files:
- `frontend/src/components/entity/supplier/Suppliers.tsx`
- `frontend/src/components/entity/supplier/SupplierDetail.tsx`
- `frontend/src/api/services/supplierService.ts` (or inline fetch calls)
- Updated `frontend/src/App.tsx` (add routes)
- Updated `frontend/src/components/Navigation.tsx` (add link)

### Phase 4: Final Validation
1. Run `npm run build --workspace=frontend` — must compile
2. Run frontend tests — all must pass
3. Start the app and verify the Suppliers page works end-to-end
4. Use Copilot Code Review on the complete diff

### Optional: Hand Off Remaining Work
If the feature needs polish (styling, edge cases), hand it off to Coding Agent:

```
/handoff-to-copilot-coding-agent
```

## Technical References
- **Frontend patterns:** Study `frontend/src/components/entity/product/Products.tsx` for similar list page
- **API endpoints:** `GET /api/suppliers`, `GET /api/suppliers/:id`, `PUT /api/suppliers/:id`
- **Existing agents:** `.github/agents/tdd-planner.agent.md`, `tdd-red.agent.md`, `tdd-green.agent.md`
- **Styling:** Follow existing Tailwind classes in the components directory
- **Routing:** See `frontend/src/App.tsx` for React Router v7 setup

## Success Criteria
- [ ] `@tdd-planner` produced a structured test plan
- [ ] `@tdd-red` created test files with meaningful failing tests
- [ ] `@tdd-green` implemented components that pass all tests
- [ ] Suppliers page accessible via navigation
- [ ] Search and filter work correctly
- [ ] Detail view shows supplier info and products
- [ ] Frontend builds without errors
- [ ] Code review has no critical findings
