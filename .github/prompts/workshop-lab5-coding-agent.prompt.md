---
mode: 'agent'
description: 'Workshop Lab 5: Create GitHub issues for Coding Agent to resolve asynchronously'
tools: ['changes', 'codebase', 'fetch', 'findTestFiles', 'githubRepo', 'problems', 'search', 'searchResults', 'usages', 'add_sub_issue', 'assign_copilot_to_issue', 'create_issue', 'get_issue', 'list_issues', 'list_sub_issues', 'search_issues', 'update_issue', 'github']
---

# 🤖 Lab 5: Coding Agent — Async Backlog Crusher

## Context
This is a workshop lab for "Reducing Developer Toil." The goal is to demonstrate how GitHub Copilot Coding Agent can autonomously resolve backlog issues while you focus on high-value work.

## Objective
Create 3 GitHub Issues representing common "easy win" backlog items, then assign them to Copilot Coding Agent for async resolution. Monitor progress in Agent HQ.

## Instructions

### Step 1: Create the Issues

Create the following 3 issues in the GitHub repository. Use the label `workshop` and `enhancement` for each.

---

**Issue A: Add input validation (zod) to Supplier and Product API routes**

```markdown
## Description
Add request body validation using `zod` to the POST and PUT handlers for Suppliers and Products. Currently, these routes accept `req.body` directly without any validation — invalid payloads silently create bad data.

## Requirements
- Install `zod` as a dependency in the `api/` workspace
- Create validation schemas in `api/src/models/supplier.ts` and `api/src/models/product.ts` (or a separate `validators/` directory)
- Schemas should match the existing TypeScript interfaces
- Apply validation in POST and PUT route handlers
- Return 400 with descriptive error messages on validation failure
- Follow existing error patterns in `api/src/utils/errors.ts`

## Acceptance Criteria
- [ ] `zod` installed in `api/package.json`
- [ ] Supplier schema validates: name (required string), contactEmail (optional, valid email format)
- [ ] Product schema validates: name (required), price (positive number), sku (required string)
- [ ] Invalid POST/PUT requests return 400 with field-level errors
- [ ] Existing tests still pass
- [ ] Build passes (`npm run build --workspace=api`)
```

---

**Issue B: Create GitHub issue and PR templates**

```markdown
## Description
The repository has no issue or PR templates, making it harder for contributors to provide structured information. Add standard templates.

## Requirements

### Issue Templates
Create `.github/ISSUE_TEMPLATE/bug_report.md`:
- Title prefix: `[Bug]`
- Sections: Description, Steps to Reproduce, Expected Behavior, Actual Behavior, Environment, Screenshots
- Labels: `bug`

Create `.github/ISSUE_TEMPLATE/feature_request.md`:
- Title prefix: `[Feature]`
- Sections: Description, Use Case, Proposed Solution, Alternatives Considered, Additional Context
- Labels: `enhancement`

### PR Template
Create `.github/PULL_REQUEST_TEMPLATE.md`:
- Sections: Description, Type of Change (checkboxes), Testing, Checklist
- Checklist items: tests pass, docs updated, no breaking changes, follows code style

## Acceptance Criteria
- [ ] Bug report template exists and renders correctly in GitHub UI
- [ ] Feature request template exists and renders correctly
- [ ] PR template appears when creating new PRs
- [ ] Templates reference this supply chain application specifically
```

---

**Issue C: Add seed data for orders and deliveries**

```markdown
## Description
The database has seed data for suppliers (001), headquarters (002), branches (003), and products (004) — but NO seed data for orders, order_details, or deliveries. This makes it impossible for new developers to test order-related flows without manually creating data.

## Requirements
Create the following seed files:

### `api/database/seed/005_orders.sql`
- 5-8 sample orders linked to existing branch IDs (1, 2)
- Various statuses: 'pending', 'processing', 'shipped', 'delivered'
- Dates spanning the last 30 days

### `api/database/seed/006_order_details.sql`
- 10-15 order detail records linking orders to existing product IDs (1-12)
- Realistic quantities (1-10) and unit prices matching product prices

### `api/database/seed/007_deliveries.sql`
- 4-6 delivery records linked to existing supplier IDs (1-3)
- Various statuses: 'pending', 'in_transit', 'delivered'
- Dates aligned with order dates

### `api/database/seed/008_order_detail_deliveries.sql`
- Junction records linking order_details to deliveries

## Acceptance Criteria
- [ ] All seed files use valid FK references to existing data
- [ ] SQL is valid SQLite syntax
- [ ] Data tells a coherent story (orders placed → deliveries created)
- [ ] Application starts without errors after re-seeding
```

### Step 2: Assign to Copilot Coding Agent

For each issue:
1. Assign Copilot as the assignee
2. The Coding Agent will automatically create a branch and begin working

### Step 3: Provide Summary

After creating all 3 issues, provide:
- Links to each issue
- Confirmation that Copilot is assigned
- Instructions to monitor progress in Agent HQ

## Success Criteria
- [ ] 3 issues created with detailed descriptions
- [ ] All 3 assigned to Copilot Coding Agent
- [ ] Issues have appropriate labels
- [ ] Summary with links provided
