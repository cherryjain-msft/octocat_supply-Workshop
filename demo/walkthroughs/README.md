# OctoCAT Supply Chain Management - Demo Walkthroughs

Comprehensive demo environment showcasing GitHub's enterprise features using a modern TypeScript web application (React frontend + Express API) with an OctoCat Style!

## 🚀 Quick Setup

**Many demos can be shown without an IDE!** Most GitHub features (Issues, Projects, Actions, GHAS, Pull Requests) are web-based and don't require local development setup.

### For IDE-Based Demos

#### Option 1: Codespaces (Recommended)

- ✅ Zero setup - everything pre-configured
- ✅ Docker and dependencies included
- ✅ Automatic API endpoint detection for browser and local VS Code
- ❌ Some Copilot MCP demos (e.g., Playwright) won't work

#### Option 2: Local Checkout

- ✅ Full functionality including all MCP demos
- ✅ Better performance for intensive tasks
- ❌ Requires local setup (see [main README](../../README.md) for instructions)
- **Requirements**: Docker, GitHub PAT with repo permissions

### (optional) VSCode Insiders

You don't need VS Code Insiders unless demoing preview features. In Codespaces, switch via the gear icon (bottom-left) → `Switch to Insiders Version...`

![Switch to Insiders](./images/vscode-switch-to-insiders.png)

## 📚 Available Walkthroughs

### 🛠️ Agent Skills

**File:** [agent-skills.md](./agent-skills.md)

Demonstrate how Agent Skills encode specific knowledge/patterns/instructions for consistent code generation:

- **Skills Overview**: What Agent Skills are and how they work - as well as when to use Skills vs Custom Instructions
- **API Endpoint Generation**: Use the `api-endpoint` skill to add a new entity (DeliveryVehicle)
- **Pattern Adherence**: Show how generated code follows the encapsulated skill definition

### 🔧 Reducing Developer Toil

**File:** [reducing-developer-toil.md](./reducing-developer-toil.md)

Hands-on workshop covering 7 labs that demonstrate how to reduce repetitive development tasks using GitHub Copilot features including custom instructions, prompt files, agent skills, and coding agents.

## 💡 Tips for Success

- **Non-deterministic AI**: Copilot responses vary - be prepared to adapt
- **Practice**: Rehearse all scenarios before live demonstrations

---

**Need help?** Each walkthrough file contains detailed step-by-step instructions and troubleshooting guidance for successful demonstrations.
