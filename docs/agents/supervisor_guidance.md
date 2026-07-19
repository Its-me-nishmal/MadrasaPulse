# Supervisor Guidance: Frontend API Integration Guidelines

**Author:** Antigravity (Supervisor Agent)  
**Target:** Flutter Frontend Agents (A8 - A12)  
**Date:** 2026-07-19  

To ensure the Flutter client operates efficiently and securely with the backend API, adhere to these implementation guidelines:

---

## 1. Role-Based Access Control (RBAC) Guarding
The backend enforces permission checks based on user claims. The frontend must validate user roles and permissions dynamically before rendering action controls:

*   **Permissions Mapping:** Refer to `core/models/user.dart` or fetch current claims.
*   **Actions Checking:**
    *   **Student Promotions:** Only enable promotion selectors/buttons if user permissions include `students:promote` or `*` (wildcard).
    *   **Fees & Invoicing:** Only enable "Post Invoice" or "Record Payment" if user has `fees:write`.
    *   **Exams Entry:** Only show marks editing grids if user has `exams:write`.

**⚠ Execution Gap:** `RoleGuard` widget exists in `shared/widgets/role_guard.dart` but is NOT wired into any A8–A12 screen. This is a post-merge task.

---

## 2. Space-Optimized Bucketing Alignments

### A. Attendance Module (A10)
*   **API Mapping:** `GET /api/v1/attendance/sheet?classId={classId}&monthYear={yyyy-mm}`
*   **Data Scoping:** Do NOT perform open-ended attendance queries. Scoped fetches by `monthYear` to load monthly class grid buckets.
*   **Grid updates:** Update daily logs using `POST /api/v1/attendance` payload body:
    ```json
    {
      "classId": "class_id_here",
      "date": "2026-07-19",
      "records": [
        { "studentId": "student_id", "status": "Present" }
      ]
    }
    ```
*   **✅ Implementation:** `attendance_repository.dart` has `submitAttendance()`, `getMonthlySheet()`, `getSummary()`.
*   **⚠ Screen stubs:** `attendance_take_screen.dart` and `attendance_month_screen.dart` are placeholders.

### B. Fees & Financials Module (A11)
*   **Academic Year Ledger:** Fetch historical student financials using `GET /api/v1/fees/ledger/{studentId}?academicYear={yyyy-yyyy}`.
*   **Transactions Capturing:** Use `POST /api/v1/fees/pay` to post cash or online payments.
*   **⚠ Gap:** `fee_repository.dart` only implements `getLedger()` — no payment posting yet.

### C. Exams & Results Module (A12)
*   **Marks Sheets Posting:** Use `POST /api/v1/exams` to submit class scores grids. Ensure `marksObtained` is validated to not exceed `maxMarks`.
*   **Report Card Compilations:** Use `GET /api/v1/exams/report/{studentId}` to aggregate multi-subject grade history percentages.
*   **⚠ Gap:** `exam_repository.dart` is empty (no post/get methods implemented).

---

## 3. Dio Client Configuration
*   ✅ All requests pass `Authorization: Bearer <accessToken>` header via interceptor.
*   ✅ JWT token rotation on 401 via /api/v1/auth/refresh is implemented in `dio_client.dart`.
*   ✅ `dio_client.dart` exposes `setTokens()`, `clearTokens()`, `get/post/put/delete` methods.

---

## 4. Validation Results (Post-Execution)

| Check | Result |
|---|---|
| `flutter analyze` errors | **0** |
| `flutter analyze` warnings/infos | **50** (trailing commas, deprecations — non-blocking) |
| `flutter test` | **14/14 passed** |
| Branch | `feature/flutter-frontend` |
| Key screens stubbed | attendance_take, attendance_month, attendance_summary, fee_dashboard, payment, grade_entry, report_card |
| `app.dart` | Not created — `MadrasaPulseApp` lives in `main.dart` |
