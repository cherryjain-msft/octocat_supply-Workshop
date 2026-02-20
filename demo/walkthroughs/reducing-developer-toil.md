# 🔧 Reducing Developer Toil — Advanced GitHub Copilot Workshop

> **Format:** Self-paced, guided labs | **Duration:** 3–4 hours (half-day)
> **Audience:** Developers already using GitHub Copilot
> **Prerequisites:** VS Code with Copilot Chat (Agent Mode), Coding Agent access on the repo

---

## 🎯 Workshop Narrative

You've just joined **Team OctoCAT** — a supply-chain management company shipping a full-stack TypeScript app. The team has a healthy codebase but a growing backlog of *toil*: repetitive, automatable tasks that keep developers out of flow. Your mission: **use GitHub Copilot's agentic capabilities to eliminate toil, ship faster, and prove it with data.**

Each lab targets a real toil pattern, measures time saved, and unlocks progressively more advanced Copilot features.

---

## 📊 Toil Measurement Framework

Every lab is scored on three dimensions. Track your results in the [scorecard](#-toil-reduction-scorecard) at the end.

| Dimension | How to Measure |
|-----------|---------------|
| **⏱️ Time Saved** | Estimated manual time vs. actual Copilot-assisted time |
| **📄 Output Generated** | Files created/modified, lines of code, test cases |
| **🔥 Toil Score** | `Frequency × Manual Effort × Automatable` (each 1–5, max 125) |

---

## 🗺️ Workshop Overview

| # | Lab | Toil Category | Copilot Feature | Est. Time |
|---|-----|---------------|-----------------|-----------|
| 0 | Setup & Orientation | — | — | 15 min |
| 1 | Kill the Boilerplate | Backlog & Scaffolding | Agent Mode + Skills | 25 min |
| 2 | Docs That Write Themselves | Code Hygiene | Agent Mode + Custom Instructions | 20 min |
| 3 | Test Coverage Blitz | Testing & Quality | Agent Mode + Prompt Files | 25 min |
| 4 | Lint, Fix, Ship | Code Hygiene | Agent Mode + Code Review | 20 min |
| 5 | Coding Agent: Async Backlog Crusher | Backlog & Tech Debt | Coding Agent + Agent HQ | 30 min |
| 6 | Agent HQ: Parallel Experimentation | Tech Debt & Architecture | Agent HQ + Parallelism | 30 min |
| 7 | Custom Agent: Full-Stack Feature | End-to-End SDLC | Custom Agents + Agentic Workflow | 30 min |

**Total ≈ 3.5 hours** (including breaks)

---

## Lab 0: Setup & Orientation (15 min)

### What You'll Learn
- How the OctoCAT Supply codebase is structured
- How to identify toil in a real codebase
- How to read the Toil Scorecard

### Steps

1. Clone the repo and run `make build` (or use the **Build All** VS Code task).
2. Start the app: `./start.ps1` (Windows) or `docker compose up`.
3. Open `http://localhost:5173` — explore the Products page, Cart, Admin.
4. Open `http://localhost:3000/api-docs` — explore the Swagger API.
5. Review the architecture: read [`docs/architecture.md`](../../docs/architecture.md).
6. Review existing Copilot config:
   - `.github/copilot-instructions.md` — repo-wide guidelines
   - `.github/instructions/` — path-scoped instructions (api, database, frontend)
   - `.github/skills/api-endpoint/` — reusable skill for endpoint generation
   - `.github/agents/` — custom agents (TDD, BDD, API specialist)
   - `.github/prompts/` — reusable prompt files

### Identify the Toil

Open the codebase and note these gaps (this is your backlog for the workshop):

- ❌ 6 of 7 repositories have **no** unit tests (only `suppliersRepo.test.ts` exists)
- ❌ No JSDoc on most API routes and repositories
- ❌ No input validation (zod/joi) on any API endpoint
- ❌ No frontend pages for Suppliers, Orders, Branches, Headquarters
- ❌ No API service layer in frontend (just a config file)
- ❌ No issue or PR templates
- ❌ Duplicated error-handling patterns across routes
- ❌ No health check endpoint
- ❌ Missing seed data for orders and deliveries

---

## Lab 1: Kill the Boilerplate — API Endpoint Scaffolding (25 min)

### 🔥 Toil Profile

| Frequency | Manual Effort | Automatable | **Toil Score** |
|-----------|--------------|-------------|----------------|
| 5 (every feature) | 4 (30–45 min manual) | 5 (highly) | **100** |

### The Toil

Every new entity requires: model interface → repository class → route handlers → Swagger docs → migration → seed data → register in `index.ts`. That's 7+ files following the exact same pattern. Pure toil.

### What You'll Learn

- **Skills** — how `.github/skills/api-endpoint/` generates entire endpoint stacks
- **Agent Mode** — multi-file generation in a single conversation
- **Custom Instructions** — how path-scoped instructions guide generation quality

### Steps

1. **Review the existing skill.** Open `.github/skills/api-endpoint/SKILL.md` and its reference docs. Notice how it codifies the team's patterns for models, repos, routes, errors, testing, and Swagger.

2. **Invoke the skill in Agent Mode.** Open Copilot Chat (Agent Mode) and use the prompt file:

   ```
   /workshop-lab1-boilerplate
   ```

   Or type manually:

   ```
   Using the api-endpoint skill, generate a complete API endpoint stack for a new
   "Warehouse" entity with these fields:
   - id (integer, auto-increment)
   - name (string, required)
   - location (string, required)
   - capacity (integer, required)
   - currentStock (integer, default 0)
   - managerId (integer, nullable)
   - isActive (boolean, default true)

   Include: model, repository, route with full CRUD + Swagger, migration, seed data.
   Register the route in index.ts.
   ```

3. **Observe.** Watch Agent Mode create 5–7 files following exact codebase conventions — because the skill + instructions guide it.

4. **Validate.** Run `npm run build --workspace=api` — it should compile cleanly.

5. **Measure.** Count files created, lines generated, and compare to your estimate of manual time.

### ✅ Done When

- [ ] `api/src/models/warehouse.ts` — TypeScript interface + Swagger schema
- [ ] `api/src/repositories/warehousesRepo.ts` — CRUD + singleton factory
- [ ] `api/src/routes/warehouse.ts` — GET/POST/PUT/DELETE + Swagger JSDoc
- [ ] `api/database/migrations/003_warehouses.sql` — DDL
- [ ] `api/database/seed/005_warehouses.sql` — sample data
- [ ] Route registered in `api/src/index.ts`
- [ ] `npm run build --workspace=api` passes

### 💡 Key Takeaway

Skills encode your team's patterns so Copilot doesn't just generate *code* — it generates code *your way*. One prompt replaced 30–45 minutes of boilerplate.

---

## Lab 2: Docs That Write Themselves — Documentation Scaffolding (20 min)

### 🔥 Toil Profile

| Frequency | Manual Effort | Automatable | **Toil Score** |
|-----------|--------------|-------------|----------------|
| 4 (every PR) | 3 (15–20 min) | 5 (highly) | **60** |

### The Toil

Most repository and utility files lack JSDoc. New team members spend time reading implementation code instead of docs. Writing docs after the fact is tedious and often skipped.

### What You'll Learn

- **Custom Instructions** — how `.github/instructions/api.instructions.md` guides doc style
- **Agent Mode** — bulk documentation across multiple files
- **Code Review** — how Copilot review catches missing docs

### Steps

1. **Audit the gap.** Open `api/src/repositories/branchesRepo.ts` — note the lack of JSDoc on class methods. Same for `ordersRepo.ts`, `productsRepo.ts`, etc.

2. **Use the prompt file** (or Agent Mode manually):

   ```
   /workshop-lab2-docs
   ```

3. **Review with Copilot Code Review.** After accepting changes, use Copilot's code review feature to validate the documentation quality.

4. **Add API README.** Ask Copilot to generate an `api/README.md` covering architecture, setup, and endpoint summary.

### ✅ Done When

- [ ] All 7 repository files have JSDoc on every public method
- [ ] `api/README.md` exists with architecture overview
- [ ] No logic changes — only documentation added
- [ ] Code review found no issues

### 💡 Key Takeaway

Custom instructions ensure generated docs match your team's voice. Copilot Code Review acts as a second pair of eyes. Documentation is no longer "I'll do it later."

---

## Lab 3: Test Coverage Blitz — Unit Test Scaffolding (25 min)

### 🔥 Toil Profile

| Frequency | Manual Effort | Automatable | **Toil Score** |
|-----------|--------------|-------------|----------------|
| 5 (every feature) | 5 (45–60 min) | 4 (high pattern) | **100** |

### The Toil

Only `suppliersRepo.test.ts` exists for repository tests. 6 repositories are completely untested. Writing tests is the #1 thing developers skip under deadline pressure — and the #1 thing that bites them later.

### What You'll Learn

- **Prompt Files** — using `.github/prompts/` for repeatable test generation
- **Agent Mode** — self-healing test execution (fix failures automatically)
- **Test patterns** — how existing test conventions propagate

### Steps

1. **Review the existing test.** Open `api/src/repositories/suppliersRepo.test.ts` and `api/src/routes/branch.test.ts` — understand the patterns (vitest, mocking, setup/teardown).

2. **Use the existing prompt** `demo-unit-test-coverage` to see Copilot generate route tests with self-healing.

3. **Now tackle repository tests** using the workshop prompt:

   ```
   /workshop-lab3-tests
   ```

4. **Validate.** Run `npm run test --workspace=api` — all tests should pass.

5. **Check coverage.** Run `npx vitest --coverage` and note the improvement.

### ✅ Done When

- [ ] 3+ new repository test files created
- [ ] All tests pass (`npm run test --workspace=api`)
- [ ] Coverage increased measurably
- [ ] Agent self-healed at least one test failure

### 💡 Key Takeaway

Prompt files make test generation repeatable across your team. Agent Mode's self-healing means generated tests actually *work* — not just compile.

---

## Lab 4: Lint, Fix, Ship — Bulk Code Hygiene (20 min)

### 🔥 Toil Profile

| Frequency | Manual Effort | Automatable | **Toil Score** |
|-----------|--------------|-------------|----------------|
| 4 (every sprint) | 3 (15–20 min) | 5 (fully) | **60** |

### The Toil

Duplicated error handling in routes (`parseInt` + `NotFoundError` check repeated in every handler). Missing input validation. No health check endpoint. These are "easy wins" that pile up because no single one justifies a PR.

### What You'll Learn

- **Code Review** — Copilot identifying code smells and DRY violations
- **Agent Mode** — refactoring across multiple files
- **Custom Instructions** — how instructions prevent anti-patterns in new code

### Steps

1. **Use the DRY violations prompt.** Run the existing `check-dry-violations` prompt to have Copilot analyze the codebase for duplicate patterns.

2. **Refactor shared patterns** with the workshop prompt:

   ```
   /workshop-lab4-lint-fix
   ```

3. **Code Review the changes.** Use Copilot Code Review on the diff to validate the refactoring.

4. **Run tests.** Verify nothing broke: `npm run test --workspace=api`.

### ✅ Done When

- [ ] `parseId()` utility or middleware exists and is used in 2+ route files
- [ ] Health check endpoint works at `GET /api/health`
- [ ] All existing tests still pass
- [ ] Code review approved the changes

### 💡 Key Takeaway

Small code hygiene tasks compound. Copilot can batch-fix them in minutes, keeping the codebase clean without burning a sprint.

---

## Lab 5: Coding Agent — Async Backlog Crusher (30 min)

### 🔥 Toil Profile

| Frequency | Manual Effort | Automatable | **Toil Score** |
|-----------|--------------|-------------|----------------|
| 5 (constant) | 4 (30–45 min each) | 4 (with context) | **80** |

### The Toil

The backlog has 3–5 "easy win" issues that any developer could do but nobody wants to pick up: add input validation, create PR/issue templates, add missing seed data. Each takes 30 minutes but interrupts focus.

### What You'll Learn

- **Coding Agent** — assigning issues to Copilot for async resolution
- **Agent HQ** — monitoring progress of coding-agent sessions
- **Handoff prompts** — using `.github/prompts/handoff-to-copilot-coding-agent.prompt.md`

### Pre-Lab Setup

Create these GitHub Issues (or use the pre-created templates):

| Issue | Title |
|-------|-------|
| A | Add input validation (zod) to Supplier and Product API routes |
| B | Create GitHub issue and PR templates |
| C | Add seed data for orders and deliveries |

Use the prompt file to auto-create them:

```
/workshop-lab5-coding-agent
```

### Steps

1. **Assign issues to Coding Agent.** For each issue, assign Copilot as the assignee. The Coding Agent picks them up automatically.

2. **Monitor in Agent HQ.** Open Agent HQ (`github.com` → **Copilot** → **Agent HQ**) and watch the three sessions progress.

3. **Review the PRs.** As each session completes, review the generated PRs. Use Copilot Code Review to validate.

4. **Alternative — use the handoff prompt.** If you prefer to start from a local session, open `.github/prompts/handoff-to-copilot-coding-agent.prompt.md`, work on a task locally, then hand it off.

### ✅ Done When

- [ ] 3 issues assigned to Coding Agent
- [ ] 3 PRs created (one per issue)
- [ ] Agent HQ shows all sessions completed
- [ ] At least 2 PRs are merge-ready after review

### 💡 Key Takeaway

Coding Agent turns your backlog into a parallel processing pipeline. "Easy wins" get done while you focus on complex work. Agent HQ gives you visibility without context switching.

---

## Lab 6: Agent HQ — Parallel Tech Debt Elimination (30 min)

### 🔥 Toil Profile

| Frequency | Manual Effort | Automatable | **Toil Score** |
|-----------|--------------|-------------|----------------|
| 3 (quarterly) | 5 (hours per approach) | 5 (parallel eval) | **75** |

### The Toil

Tech debt decisions require experimentation: "Should we use zod or joi? Context API or Zustand? Middleware-based or per-route error handling?" Evaluating alternatives manually is expensive.

### What You'll Learn

- **Agent HQ Parallelism** — running multiple coding-agent sessions on different approaches
- **Parallel Experimentation** — comparing implementations side-by-side
- **Decision Making** — using Copilot output to make informed tech decisions

### Steps

1. **Create a parent issue (Epic):**

   ```
   Title: "Frontend API Service Layer — Evaluate Approaches"

   The frontend currently has no API service abstraction (only api/config.ts).
   We need a typed service layer for making API calls. Evaluate 3 approaches.
   ```

2. **Create 3 sub-issues** with different approaches:

   | Sub-Issue | Approach |
   |-----------|----------|
   | A | Axios wrapper with TypeScript generics |
   | B | React Query custom hooks |
   | C | OpenAPI-generated client from `api-swagger.json` |

   Use the prompt file:

   ```
   /workshop-lab6-parallel
   ```

3. **Assign all 3 to Coding Agent** simultaneously.

4. **Monitor in Agent HQ.** Watch all three sessions run in parallel.

5. **Compare PRs.** Use Copilot to summarize the differences:

   ```
   Compare these three PRs and recommend which API service layer approach
   is best for our codebase in terms of: type safety, maintainability,
   bundle size, and developer experience.
   ```

### ✅ Done When

- [ ] 3 parallel coding-agent sessions launched
- [ ] 3 PRs with different approaches generated
- [ ] Copilot-generated comparison summary exists
- [ ] Team can make an informed decision on which approach to adopt

### 💡 Key Takeaway

Agent HQ turns experimentation from "days of developer time" into "30 minutes of parallel evaluation." Tech debt decisions get data, not opinions.

---

## Lab 7: Custom Agent — End-to-End Feature with Agentic Workflow (30 min)

### 🔥 Toil Profile

| Frequency | Manual Effort | Automatable | **Toil Score** |
|-----------|--------------|-------------|----------------|
| 3 (per feature) | 5 (2–4 hours) | 3 (needs orchestration) | **45** |

### The Toil

Building a full-stack feature touches every layer: model → migration → repository → route → API service → frontend component → tests. Coordinating all these steps is the *meta-toil* of software development.

### What You'll Learn

- **Custom Agents** — building domain-specific agents (`.github/agents/`)
- **Agent Handoffs** — chaining agents in a TDD/BDD workflow
- **Agentic Workflow** — end-to-end feature development with Copilot orchestrating the process

### Steps

1. **Review existing custom agents.** Read `.github/agents/` — notice the TDD agents (`tdd-planner`, `tdd-red`, `tdd-green`) and domain agents (`api-specialist`, `bdd-specialist`).

2. **Plan with the TDD Planner agent:**

   ```
   @tdd-planner Plan a Suppliers Management page for the frontend.

   Requirements:
   - List all suppliers with name, status (active/verified), product count
   - Search/filter by name and status
   - Click supplier to see detail view with their products
   - Admin can toggle active/verified status
   - Uses the existing /api/suppliers endpoints
   - Follows existing frontend patterns (React + Tailwind + React Query)
   ```

3. **Red phase — write failing tests first.** Use `@tdd-red` to generate test files based on the plan.

4. **Green phase — implement to pass.** Use `@tdd-green` (or Agent Mode) to implement the components until all tests pass.

5. **Hand off remaining work.** If time is short, use the handoff prompt:

   ```
   /handoff-to-copilot-coding-agent
   ```

6. **Code Review.** Use Copilot Code Review on the final diff.

### ✅ Done When

- [ ] Suppliers page renders with data from the API
- [ ] Search/filter works
- [ ] Tests pass
- [ ] Code review has no critical findings
- [ ] Feature accessible via navigation

### 💡 Key Takeaway

Custom agents encode your team's *workflow* — not just code patterns. The TDD agent chain demonstrates how Copilot can orchestrate a development methodology, not just generate individual files.

---

## 📊 Toil Reduction Scorecard

Fill this in as you complete each lab:

| Lab | Toil Score | Est. Manual Time | Copilot Time | Time Saved | Files Created | Lines Generated |
|-----|-----------|-----------------|-------------|-----------|--------------|----------------|
| 1: Boilerplate | 100 | 45 min | ___ min | ___% | ___ | ___ |
| 2: Documentation | 60 | 20 min | ___ min | ___% | ___ | ___ |
| 3: Test Coverage | 100 | 60 min | ___ min | ___% | ___ | ___ |
| 4: Code Hygiene | 60 | 20 min | ___ min | ___% | ___ | ___ |
| 5: Backlog (CCA) | 80 | 90 min | ___ min | ___% | ___ | ___ |
| 6: Parallel Eval | 75 | 4+ hrs | ___ min | ___% | ___ | ___ |
| 7: Full Feature | 45 | 3+ hrs | ___ min | ___% | ___ | ___ |
| **TOTAL** | **520** | **~9 hrs** | **___ min** | **___% ** | **___** | **___** |

### How to Calculate

- **Time Saved** = `(Manual − Copilot) / Manual × 100`
- **Toil Score** = `Frequency × Manual Effort × Automatable` (each 1–5)
- **Workshop ROI** = Total Manual Time Saved × Number of Developers × Frequency per Year

---

## 🏗️ Copilot Feature Coverage Map

| Copilot Feature | Lab(s) | What It Does |
|----------------|--------|-------------|
| **Agent Mode** | 1, 2, 3, 4 | Multi-file generation, self-healing, iterative development |
| **Skills** | 1 | Reusable, pattern-encoded generation templates |
| **Custom Instructions** | 1, 2, 4 | Path-scoped rules that shape all Copilot output |
| **Prompt Files** | 3, 5 | Repeatable, shareable prompts with tool/mode config |
| **Code Review** | 2, 4, 5, 7 | AI-powered review of diffs and PRs |
| **Coding Agent** | 5, 6 | Async, issue-driven code generation via PRs |
| **Agent HQ** | 5, 6 | Dashboard for monitoring parallel coding-agent sessions |
| **Parallelism** | 6 | Multiple coding-agent sessions evaluating alternatives |
| **Custom Agents** | 7 | Domain-specific agents with specialized instructions |
| **Agent Handoffs** | 5, 7 | Transferring work between local session and Coding Agent |
| **TDD Workflow** | 7 | Planner → Red → Green agent chain |

---

## 📋 Facilitator Notes

### Pre-Workshop Checklist

- [ ] Repo cloned and builds successfully (`make build`)
- [ ] VS Code with Copilot extension (latest)
- [ ] Copilot Chat with Agent Mode enabled
- [ ] Coding Agent access enabled on the GitHub repository
- [ ] MCP servers configured (optional: Playwright, GitHub)
- [ ] Pre-create GitHub Issues for Labs 5 and 6
- [ ] Verify `.github/skills/api-endpoint/SKILL.md` exists
- [ ] Verify `.github/agents/` directory has TDD agents

### Timing Guidelines

| Segment | Duration |
|---------|----------|
| Lab 0: Setup | 15 min |
| Labs 1-4: Interactive (Agent Mode) | 90 min |
| Break | 10 min |
| Labs 5-7: Agentic (Coding Agent + Agent HQ) | 75 min |
| Wrap-up & Scorecard Review | 15 min |

### Key Messages to Reinforce

1. **Toil is measurable** — the scorecard proves ROI, not just vibes.
2. **Skills + Instructions = institutional knowledge** — Copilot generates code *your team's way*.
3. **Coding Agent + Agent HQ = parallel developer** — backlog items get done while you do deep work.
4. **Custom Agents encode process, not just patterns** — TDD, BDD, security review can all be agents.
5. **Agentic workflows keep developers in flow** — the #1 productivity metric.

### Customization Options

- **Shorter version (2 hrs):** Do Labs 0, 1, 3, 5 only.
- **Leadership version (1.5 hrs):** Demo Labs 1 and 3 live, show Agent HQ for Lab 6, present scorecard.
- **Extended version (full day):** Add accessibility/i18n lab, E2E test lab, CI/CD pipeline generation lab.

### Related Prompt Files

| Prompt | Lab |
|--------|-----|
| `workshop-lab1-boilerplate.prompt.md` | Lab 1 |
| `workshop-lab2-docs.prompt.md` | Lab 2 |
| `workshop-lab3-tests.prompt.md` | Lab 3 |
| `workshop-lab4-lint-fix.prompt.md` | Lab 4 |
| `workshop-lab5-coding-agent.prompt.md` | Lab 5 |
| `workshop-lab6-parallel.prompt.md` | Lab 6 |
| `workshop-lab7-custom-agent.prompt.md` | Lab 7 |
