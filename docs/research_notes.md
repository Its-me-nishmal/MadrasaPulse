# MadrasaPulse — Documentation & Project Specifications Summary

This workspace artifact organizes and details the specifications of **MadrasaPulse**. All referenced Notion pages have been updated to represent complete, highly documented PRDs.

A local master specification file has been created at:
👉 **[system_specifications.md](file:///d:/MadrasaPulse/docs/system_specifications.md)**

---

## Notion Project Hub & Module Index

Here are the updated Notion pages containing the detailed technical requirements, schemas, and design constraints:

1. 🎯 **[MadrasaPulse — Vision & Goals](https://app.notion.com/p/MadrasaPulse-Vision-Goals-3a22348faea1811a86bccceabd980bcb)** (ID: `3a22348f-aea1-811a-86bc-cceabd980bcb`)
   * Core objectives, mobile-first goals, success criteria, and product promises.
2. 📱 **[MadrasaPulse — Flutter Architecture](https://app.notion.com/p/MadrasaPulse-Flutter-Architecture-3a22348faea1811da2f7e366361b85c9)** (ID: `3a22348f-aea1-811d-a2f7-e366361b85c9`)
   * Single app strategy, selected libraries (Riverpod, GoRouter, Hive, Dio), and isolated module directory structures.
3. 🧩 **[MadrasaPulse — Module System](https://app.notion.com/p/MadrasaPulse-Module-System-3a22348faea181218838fa7436059cb4)** (ID: `3a22348f-aea1-8121-8838-fa7436059cb4`)
   * Configuration of core modules and optional add-ons dynamic loading rules.
4. 🎨 **[MadrasaPulse — UI Design System](https://app.notion.com/p/MadrasaPulse-UI-Design-System-3a22348faea1815eb859e9d550550110)** (ID: `3a22348f-aea1-815e-b859-e9d550550110`)
   * Material 3 usability guidelines, spacing principles, sans-serif typography, and Stripe/Linear style reference.
5. 📘 **[MadrasaPulse — Product Hub](https://app.notion.com/p/MadrasaPulse-Product-Hub-3a22348faea181d88abfcb6ac1f61daa)** (ID: `3a22348f-aea1-81d8-8abf-cb6ac1f61daa`)
   * Central index of modules, target users, taglines, and system boundaries.
6. 👥 **[MadrasaPulse — Roles & Permissions](https://app.notion.com/p/MadrasaPulse-Roles-Permissions-3a22348faea181e28fafe2c491bd92a0)** (ID: `3a22348f-aea1-81e2-8faf-e2c491bd92a0`)
   * RBAC mapping for Super Admin, Madrasa Admin, Teacher, Parent, and Student.
7. ⚙️ **[MadrasaPulse — Engineering Standards & CI/CD](https://app.notion.com/p/MadrasaPulse-Engineering-Standards-CI-CD-3a22348faea181608dccf37665b26d68)** (ID: `3a22348f-aea1-8160-8dcc-f37665b26d68`)
   * Repository structure, Git branching guidelines, PR checks, GitHub Actions pipelines, and linter settings.
8. 🤖 **[MadrasaPulse — AI Agent Flows & Multi-Agent Architecture](https://app.notion.com/p/MadrasaPulse-AI-Agent-Flows-Multi-Agent-Architecture-3a22348faea181f6bd66c15b58495383)** (ID: `3a22348f-aea1-81f6-bd66-c15b58495383`)
   * Dual architecture overview: (1) Developer Subagents development pipeline and (2) App-level Coordinator & specialized AI micro-agents.
9. 💾 **[MadrasaPulse — MongoDB Scaling & Schema Patterns](https://app.notion.com/p/MadrasaPulse-MongoDB-Scaling-Schema-Patterns-3a22348faea181689021d01eb275615e)** (ID: `3a22348f-aea1-8168-9021-d01eb275615e`)
   * Document boundary designs, monthly class-attendance bucketing, yearly fee ledger partition structures, and exam scores layouts avoiding the 16MB document cap.
10. 📁 **[Student Management Module](https://app.notion.com/p/3a22348faea181f395c8d35a4d891a2c)** (ID: `3a22348f-aea1-81f3-95c8-d35a4d891a2c`)
    * Student lifecycle, profile data models, parent/guardian links, promotions, TCs, and bulk CSV operations.
11. 📁 **[Teacher Management Module](https://app.notion.com/p/3a22348faea181d2b604dc8602fc0599)** (ID: `3a22348f-aea1-81d2-b604-dc8602fc0599`)
    * Onboarding, qualification logs, subject-class allocation, and substitute leave management workflows.
12. 📁 **[Attendance Module](https://app.notion.com/p/3a22348faea18109a3bad2f3650cc4d1)** (ID: `3a22348f-aea1-8109-a3ba-d2f3650cc4d1`)
    * Classroom grids, QR scan architecture, offline storage sync, and automated SMS/WhatsApp parent alerts.
13. 📁 **[Fees & Payments Module](https://app.notion.com/p/3a22348faea1818ba9a8cf357e84f84b)** (ID: `3a22348f-aea1-818b-a9a8-cf357e84f84b`)
    * Invoicing calendars, Stripe/Razorpay integrations, PDF receipts, and automated debt warnings.
14. 📁 **[Exams & Results Module](https://app.notion.com/p/3a22348faea1810fb652d1b056f17696)** (ID: `3a22348f-aea1-810f-b652-d1b056f17696`)
    * Grade metrics, spreadsheet mark-entry screens, and printable report cards.
15. 📁 **[Database Architecture](https://app.notion.com/p/3a22348faea181e488fbfc0aac834888)** (ID: `3a22348f-aea1-81e4-88fb-fc0aac834888`)
    * Logical multi-tenancy configurations, shared MongoDB collections with `madrasaId`, indexing recommendations, and soft deletes.
16. 📁 **[REST API Specification](https://app.notion.com/p/3a22348faea1812d954be912da8e207e)** (ID: `3a22348f-aea1-812d-954b-e912da8e207e`)
    * Common response templates, HTTP codes, pagination, and tenant verification headers.
17. 📁 **[Authentication & Authorization](https://app.notion.com/p/3a22348faea181c5aa74fd38e950795a)** (ID: `3a22348f-aea1-81c5-aa74-fd38e950795a`)
    * Access & Refresh JWT tokens setup, claims payloads, device locks, and permissions lists.
18. 📁 **[Super Admin Platform](https://app.notion.com/p/3a22348faea181d1992dec8a85e91656)** (ID: `3a22348f-aea1-81d1-992d-ec8a85e91656`)
    * System administrator dashboard, billing entitlements, and server resources analytics.
19. 📁 **[Development Roadmap](https://app.notion.com/p/3a22348faea181848934d757b0d209e6)** (ID: `3a22348f-aea1-8184-8934-d757b0d209e6`)
    * Five phases mapping infrastructure setup, core operations, finance, notifications, and app publication.

---

## Free Hosting & CI/CD Deployment Guide

To deploy the **MadrasaPulse** stack entirely for free for demonstration, testing, or staging, utilize the following resource combinations:

### 1. Database Hosting (MongoDB Atlas)
*   **Provider:** MongoDB Atlas (Free Tier)
*   **Tier:** M0 Shared Cluster (512 MB Storage)
*   **Sign-Up:** [mongodb.com/cloud/atlas](https://www.mongodb.com/cloud/atlas)
*   **Setup:** Create a free M0 cluster, configure network access (`0.0.0.0/0` for cloud services), obtain your connection string, and set it as `MONGO_URI` in the backend environment variables.

### 2. Backend Hosting (Render, Railway, or Koyeb)
*   **Option A: Render (Web Services)**
    *   **Sign-Up:** [render.com](https://render.com)
    *   **Deploy:** Connect your GitHub repository. Select Node.js web service. Set build command `npm install` and start command `npm start --workspace=backend`.
    *   *Note:* The free tier spins down after 15 mins of inactivity.
*   **Option B: Koyeb (Docker Apps)**
    *   **Sign-Up:** [koyeb.com](https://koyeb.com)
    *   **Deploy:** Deploys Dockerfiles automatically. Point it to `/backend/Dockerfile`.

### 3. Frontend Web Hosting (Vercel or GitHub Pages)
*   **Option A: Vercel**
    *   **Compile:** Run `flutter build web --release` inside the `frontend` folder.
    *   **Deploy:** Connect the repository to Vercel, select the output folder `frontend/build/web`, and deploy.
*   **Option B: GitHub Pages**
    *   Configure a GitHub Actions workflow to build and push the `build/web` directory to a `gh-pages` branch on every push.

### 4. CI/CD Pipelines (GitHub Actions)
*   GitHub provides **2,000 free minutes/month** for Actions workflows.
*   Setup `.github/workflows/test.yml` to automatically run tests:
    ```yaml
    name: Backend Test Runner
    on: [push]
    jobs:
      test:
        runs-on: ubuntu-latest
        services:
          mongodb:
            image: mongo:latest
            ports:
              - 27017:27017
        steps:
          - uses: actions/checkout@v3
          - uses: actions/setup-node@v3
            with:
              node-version: 18
          - run: npm ci
          - run: npm test --workspace=backend
    ```
