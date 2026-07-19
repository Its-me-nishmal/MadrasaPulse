# MadrasaPulse — System Specifications & PRDs

This document acts as the local master file of the system specifications, architecture, and module configurations synchronized with your Notion documentation.

---

## 1. Student Management Module
Comprehensive PRD covering student lifecycle management:
* **Admission & Profiles:** Handles self and admin-driven enrollment capturing personal (name, DOB, photo), admission, and academic details. Includes document attachments (Birth Certificates, IDs).
* **Parent/Guardian Linkage:** Grouping sibling students under primary/secondary guardians with phone/WhatsApp contacts to enable billing & notification consolidation.
* **Academic Lifecycle:** Class/section allocation, promotion engine at year-end, Transfer Certificate (TC) generation, and soft-delete archiving for an Alumni directory.
* **Search & Filters:** Global search by student details or roll number, coupled with filters (Class, Gender, Fee status) and CSV bulk import/export.

---

## 2. Teacher Management Module
Complete teacher lifecycle onboarding, scheduling, and workloads:
* **Profiles & Onboarding:** Record contact info, emergency contacts, documents (contracts, credentials), and Islamic certifications (Alim, Hafiz).
* **Allocations:** Map teachers to specific subjects and grades, designate Class Teachers, and calculate total weekly hours to monitor workload limits.
* **Leave Management:** Mobile-first leave submissions, admin approval workflows, and automated schedule substitutions.

---

## 3. Attendance Module
Daily attendance tracking for students, teachers, and staff:
* **Roster Marking:** Single-tap checklist for teachers (Present, Absent, Late, Excused) with bulk-marking shortcuts.
* **QR Codes:** Mobile camera scans parent-held student QR codes for contactless check-in.
* **Offline Sync:** Local storage (via Hive) queues markings during network drops and auto-syncs when online.
* **Parent Alerts:** Triggers SMS/WhatsApp alerts for absences and flags low attendance (<75%).

---

## 4. Fees & Payments Module
Financial ledger and payment collections:
* **Configurations:** Define annual/term/monthly fees, sibling discounts, and scholarships.
* **Invoicing:** Automatic invoice generation at billing cycle start, recorded in student ledgers.
* **Payment Gateways:** Online payments via Stripe/Razorpay (mobile/web) alongside offline cash/cheque logs.
* **Receipts & Reminders:** Automatic PDF receipts sent via WhatsApp/Email, with scheduled unpaid invoice alerts.

---

## 5. Exams & Results Module
Academic assessment setup and grading:
* **Assessments:** Semester/test schedules, total marks, pass thresholds, and custom grade scales.
* **Grade Entry:** Mobile spreadsheet-like mark-entry grid with auto-calculators for totals/ranks.
* **Report Cards:** Printable PDF report cards showing grades, attendance, and remarks.

---

## 6. Database Architecture (MongoDB)
* **Tenancy:** Single database (logical multi-tenancy) utilizing `madrasaId` indexing across all shared collections.
* **Collections:** `madrasas`, `users`, `students`, `teachers`, `attendance_logs`, `invoices`, and `exams`.
* **Indexes:** Compound indexes `{ madrasaId: 1, classId: 1 }` and text indexes on search fields.
* **Soft Deletes:** Standardized `isDeleted: Boolean` on all lifecycle entities.

---

## 7. REST API Specification
* **Endpoints Prefix:** `/api/v1`
* **Common Structure:** Paginated (`meta`) and error envelope payloads.
* **HTTP Codes:** Standard REST responses (200, 201, 400, 401, 403, 404, 429, 500).

---

## 8. Authentication & Authorization
* **JWT Tokens:** Short-lived Access Tokens (15 min) transmitting claims; long-lived Refresh Tokens (30 days) stored in mobile Secure Storage.
* **RBAC Scopes:** Granular permissions (`students:write`, `attendance:read`, etc.) validated at routes.
* **Session Protection:** Session blacklists upon logout and device lock tracking.

---

## 9. Super Admin Platform
Global SaaS control panel:
* **Tenant Setup:** Multi-tenant provisioning, subdomains, and subscription locking.
* **Billing System:** Package definitions (Basic vs. Premium) and automatic feature toggling.
* **Analytics:** CPU, memory, API latency logs, and database size indicators.

---

## 10. Development Roadmap
* **Phase 1 (W1-3) - ✅ [COMPLETED]:** Monorepo structure, DB schemas (Madrasa, Student, Teacher, Attendance buckets), Docker environment (Dockerfile & docker-compose), and JWT authentication.
* **Phase 2 (W4-8) - ✅ [COMPLETED]:** Student, Teacher, and Attendance core modules (CRUD, search, bulk promotions, class allocations, and capped attendance grids).
* **Phase 3 (W9-12) - ✅ [COMPLETED]:** Fees, Payments gateway, Exam mark grids, and PDF generation (student ledger buckets, invoice/payment recording, and multi-subject report aggregations).
* **Phase 4 (W13-15) - 🚀 [NEXT IN QUEUE]:** Parent/Student Portals, Twilio/WhatsApp APIs, and push notifications.
* **Phase 5 (W16-18):** End-to-end testing, AWS deployment, App Store and Play Store launch.

---

## 11. GitHub Workspace & Branch Management
* **Monorepo Layout:**
  * `/.github/workflows/` — Automated CI/CD.
  * `/backend/` — Express.js Node.js project.
  * `/frontend/` — Flutter mobile project.
* **Branching Strategy (Trunk-Based Hybrid):**
  * `main` — Production release-ready code.
  * `develop` — Dev integration and staging branch.
  * `feature/<desc>` — Development branch for new tasks (e.g., `feature/MP-201-payments`).
  * `bugfix/<desc>` / `hotfix/<desc>` — Bug resolution branches.
* **PR Requirements:** Require at least 1 peer approval, all lint/test pipeline workflows must pass, and commits are merged via Squash & Merge.

---

## 12. GitHub Actions CI/CD Pipelines
* **Continuous Integration (`ci-pr-check.yml`):**
  * Runs on all PRs to `develop`/`main`.
  * *Backend Jobs:* Runs linting (`npm run lint`), checks types, and executes tests (`npm run test:coverage`).
  * *Frontend Jobs:* Checks formatting (`dart format`), lint issues (`flutter analyze`), and runs tests (`flutter test`).
* **Continuous Delivery (`cd-release.yml`):**
  * Runs on merges/pushes to `develop` (staging) or `main` (production).
  * *Backend Jobs:* Builds and tags Docker image, pushes to Amazon ECR, and deploys to AWS ECS (Fargate).
  * *Frontend Jobs:* Builds production `.aab` / `.ipa` and uploads to TestFlight / Play Store Internal Testing.

---

## 13. Coding Standards & Best Practices
* **Flutter Frontend:**
  * Enforce linter rules in `analysis_options.yaml` (`avoid_print`, `require_trailing_commas`, `prefer_const_constructors`).
  * Enforce state separation utilizing Riverpod Providers.
  * Implement layouts dynamically using `MediaQuery` or screen utilities.
* **Node.js Backend:**
  * Adopt Controller-Service-Repository structural layout.
  * Payload validations at middleware layer (using `Joi` or `Zod`).
  * Strict error-handling utilizing asynchronous catch blocks.

---

## 14. AI Agent Flows & Multi-Agent Architecture
* **Developer Agent Workflows:**
  * *Supervisor Agent (Antigravity):* Orchestrates task planning, creates execution blueprints, and splits assignments among developers and QA.
  * *Developer Subagents:* Perform isolated changes on routes, models, and UI files.
  * *QA Subagents:* Independently trigger compilation, styling formats, and testing checks before merging.
* **Product Multi-Agent System (AI Assistant Module):**
  * *Coordinator Agent:* Core interaction portal routing requests based on user speech/text input.
  * *Specialized Agents:* Academic Agent (queries students/grades databases), Finance Agent (compiles payment ledgers), and Dispatch Agent (sends WhatsApp/SMS alerts).
  * *Security Protocol:* High-risk operations (e.g. executing payments, bulk promotion edits) require explicit confirmation dialog clicks from the Madrasa Admin.

---

## 15. MongoDB Scaling & Schema Patterns (Avoiding 16MB Limits)
* **Core Design Rule:** Nesting is strictly prohibited for unbounded arrays (e.g. lifetime student attendance/invoices). Nesting is allowed only when arrays have a natural cap (e.g. max 5 guardians, 20 invoice line items).
* **Attendance Bucketing:** Group logs by `classId` and `monthYear`. A class of 50 students over 30 days generates 1,500 nested entries (~85 KB, only 0.53% of 16MB limit).
* **Ledger Bucketing:** Group invoices/payments by `studentId` and `academicYear`. Max 12 monthly invoices per year generates a document under 15 KB (0.09% of 16MB limit).
* **Grades Bucketing:** Group exam results by `classId` and `examId` for rapid mobile loads (~8 KB, 0.05% of 16MB limit).
