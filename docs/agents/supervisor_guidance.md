# Supervisor Guidance: Frontend API Integration Guidelines

**Author:** Antigravity (Supervisor Agent)  
**Target:** Flutter Frontend Agents (A8 - A12)  
**Status:** REJECTED (Pending Stub Resolution & Lint Hardening)
**Date:** 2026-07-19  

The current implementation has been **REJECTED** due to incomplete placeholder screens (stubs) and excessive lint warnings. To proceed, the developer agents must resolve all gaps.

---

## 🔴 Strict Quality Standards

### 1. Zero-Lint-Warning Policy
*   All `50` warnings/infos (such as missing trailing commas, unused imports, deprecated members, or style rule violations) must be fixed.
*   Running `flutter analyze` must output exactly `No issues found!`.

### 2. Complete Screen Implementations
Stubs are strictly prohibited. Replace all placeholders in the following modules with actual production-ready interactive UIs:

*   **Attendance Module (A10):**
    *   `attendance_take_screen.dart`: Provide a toggleable student list (Present/Absent/Late) with a submit button sending data to the backend via `AttendanceController`.
    *   `attendance_month_screen.dart`: Render a monthly class grid populated with student daily logs.
    *   `attendance_summary_screen.dart`: Render statistics (presence rate, total present/absent counters).
*   **Fees & Financials Module (A11):**
    *   `payment_screen.dart` / `invoice_screen.dart`: Allow admins to input cash payments, updating balances and invoice statuses dynamically.
*   **Exams & Results Module (A12):**
    *   `exam_repository.dart` must be fully implemented. Do not leave it empty.
    *   Implement grade-sheet submission grids and individual report card viewers.

---

## 3. Role-Based Access Control (RBAC) Integration
*   The `RoleGuard` widget (`shared/widgets/role_guard.dart`) must be actively wrapped around critical administrative actions (e.g. promoting students, registering payments, or recording exam grades).
*   Buttons must be disabled or hidden if the user's role permissions do not match the required scopes.

---

## 4. Final Exit Criteria
- [ ] All stubs replaced with fully operational, server-interactive screens.
- [ ] `flutter analyze` runs clean with `0 errors`, `0 warnings`, and `0 infos`.
- [ ] All unit, widget, and mock integration tests pass successfully (`flutter test`).
