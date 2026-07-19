# MadrasaPulse Changelog

All notable changes to the MadrasaPulse project will be documented in this file.

---

## [1.5.0] - 2026-07-19 (Commit: 1e5c83f)

### Added
*   **[Daily Attendance Submission]** Built endpoints to register daily student attendance records, checking and modifying log histories dynamically inside Mongoose buckets.
*   **[Monthly Sheet Grid View]** Programmed monthly sheet lookups filterable by `classId` and `monthYear` parameters with populated student data parameters.
*   **[Attendance Analytics Engine]** Developed summary indicators returning total present/absent counts and monthly attendance percentages.
*   **[Granular Attendance Router]** Integrated Express router secured by RBAC permissions (`attendance:read`, `attendance:write`).

---

## [1.4.0] - 2026-07-19 (Commit: 9297926)

### Added
*   **[Teacher Onboarding Controller]** Created API endpoints for registering staff profiles, listing directory records, modifying credentials, and soft-delete archiving.
*   **[Class & Subject Allocations]** Implemented dynamic validation schemas linking teachers to subject domains and grade classes context.
*   **[Granular Teacher Access]** Secured routing endpoints under RBAC permission checks (`teachers:read`, `teachers:write`, `teachers:delete`).
*   **[Environment Tooling Sanitization]** Updated `.gitignore` to omit local development diagnostic outputs.

---

## [1.3.0] - 2026-07-19 (Commit: 8343d2c)

### Added
*   **[Student CRUD Controllers]** Developed endpoints for registering a new student, retrieving profiles by ID, updating personal details, and soft-delete archiving.
*   **[Paginated Student Directory]** Implemented filterable list queries supporting regex name searches, class scoping, and pagination statistics.
*   **[Bulk Student Promotion]** Built promotion controller mapping arrays of student IDs to target class IDs.
*   **[Protected Student Routes]** Added express routers guarded by RBAC permissions (`students:read`, `students:write`, `students:delete`, `students:promote`).

---

## [1.2.0] - 2026-07-19 (Commit: f0439eb)

### Added
*   **[Core Database Models]** Coded core Mongoose schemas for `Madrasa` (tenant configuration), `Student` (life-cycle profile and sibling indicators), and `Teacher` (expertise allocations and leave logs).
*   **[Capped Attendance Bucketing]** Implemented space-optimized Mongoose schema for `Attendance` buckets, grouping logs monthly to prevent 16MB document size ceiling overflows.
*   **[Production Dockerfile]** Wrote a multi-stage production Docker build script for backend Express.js server optimization.
*   **[Local Dev Orchestration]** Configured `docker-compose.yml` linking the Express REST service to a local MongoDB volume container.

---

## [1.1.0] - 2026-07-19 (Commit: 4397704)

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
