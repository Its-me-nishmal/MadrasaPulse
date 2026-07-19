# MadrasaPulse Changelog

All notable changes to the MadrasaPulse project will be documented in this file.

---

## [1.1.0] - 2026-07-19 (Commit: 8d18e17)

### Added
*   **[JWT Authentication Service]** Developed full token validation engine including Access Token generation (15m) and Refresh Token rotation (30d) logic.
*   **[User Database Schema]** Created MongoDB User collection schema with automatic pre-save password bcrypt hashing and unique tenant indexing.
*   **[Auth Endpoints]** Implemented Express controllers and router endpoints for `/register`, `/login`, and `/refresh`.
*   **[Authorization Guard Middleware]** Developed `requireAuth` and `requirePermission` middlewares to validate session states and enforce role-based access control (RBAC).

---

## [1.0.0] - 2026-07-19 (Commit: 47a074e)

### Added
*   **[Notion Synchronization]** Sync'ed and fully documented 10 module PRDs, database design specifications, REST API guides, and roadmaps in the Notion Workspace.
*   **[Local System Specifications]** Created master offline specs at [system_specifications.md](file:///d:/MadrasaPulse/docs/system_specifications.md) and [research_notes.md](file:///d:/MadrasaPulse/docs/research_notes.md).
*   **[Monorepo Architecture]** Configured root monorepo `package.json` with npm workspaces and root developer `README.md`.
*   **[Git Repository Setup]** Initialized git version control and linked remote repository origin.
