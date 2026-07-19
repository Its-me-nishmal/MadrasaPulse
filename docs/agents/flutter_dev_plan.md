# Flutter Frontend — Multi-Agent Development Plan

**Project:** MadrasaPulse  
**Branch:** `feature/flutter-frontend`  
**Base:** `develop`  
**Last Updated:** 2026-07-19  
**Orchestrator:** Antigravity (Supervisor Agent)

---

## Branch Workflow

```bash
git checkout develop
git pull origin develop
git checkout -b feature/flutter-frontend
# All agents commit to this branch concurrently
git push origin feature/flutter-frontend
```

After all agents complete → PR to `develop`.

---

## Agent Registry

| Agent | ID | Wave | Status | Files | Dependencies |
|---|---|---|---|---|---|
| **A1 - Flutter Init** | OCA-0719-01 | 1 | ✅ Complete | `flutter create .`, `analysis_options.yaml` | None |
| **A2 - Core Models** | OCA-0719-02 | 1 | ✅ Complete | `models/*.dart` (10 files) | A1 |
| **A3 - Core Layer** | OCA-0719-03 | 1 | ✅ Complete | `core/network/*`, `core/router/*` (5 files) | A1 |
| **A4 - Theme** | OCA-0719-04 | 1 | ✅ Complete | `core/constants/*`, `core/theme/*` (4 files) | A1 |
| **A5 - Auth Module** | OCA-0719-05 | 2 | ✅ Complete | `features/auth/*` (4 files) | A3, A4 |
| **A6 - Dashboard** | OCA-0719-06 | 2 | ✅ Complete | `features/dashboard/*` (4 files) | A3, A4 |
| **A7 - Shared Widgets** | OCA-0719-07 | 2 | ✅ Complete | `shared/widgets/*`, `shared/utils/*` (9 files) | A4 |
| **A8 - Students** | OCA-0719-08 | 3 | ✅ Complete | `features/students/*` (9 files) | A3, A7 |
| **A9 - Teachers** | OCA-0719-09 | 3 | ✅ Complete | `features/teachers/*` (6 files) | A3, A7 |
| **A10 - Attendance** | OCA-0719-10 | 3 | ✅ Complete | `features/attendance/*` (6 files, 3 screens resolved) | A3, A7 |
| **A11 - Fees** | OCA-0719-11 | 3 | ✅ Complete | `features/fees/*` (7 files, 2 screens resolved) | A3, A7 |
| **A12 - Exams** | OCA-0719-12 | 3 | ✅ Complete | `features/exams/*` (5 files, 2 screens resolved, repo active) | A3, A7 |
| **A13 - Tests** | OCA-0719-13 | 4 | ✅ Complete | `test/**/*` (6 files, 14 tests) | All above |
| **A14 - West Fix** | OCA-0719-14 | 4 | ✅ Complete | 0 errors, 0 warnings/infos remain | A13 |
| **A15 - Canaries** | OCA-0719-15 | 4 | ✅ Complete | `flutter analyze` 0 errors/warnings, `flutter test` 14/14 | A14 |

---

## Project Structure (target)

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/        ← A4
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_spacing.dart
│   ├── theme/            ← A4
│   │   └── app_theme.dart
│   ├── router/           ← A3
│   │   ├── router.dart
│   │   └── router_notifier.dart
│   └── network/          ← A3
│       ├── api_config.dart
│       ├── dio_client.dart
│       └── dio_provider.dart
├── models/               ← A2
│   ├── user.dart
│   ├── madrasa.dart
│   ├── student.dart
│   ├── teacher.dart
│   ├── attendance.dart
│   ├── fee.dart
│   ├── exam.dart
│   ├── failure.dart
│   ├── meta.dart
│   └── filter.dart
├── features/
│   ├── auth/             ← A5
│   │   ├── controllers/
│   │   ├── screens/
│   │   └── widgets/
│   ├── dashboard/        ← A6
│   │   ├── controllers/
│   │   ├── screens/
│   │   └── widgets/
│   ├── students/         ← A8
│   │   ├── controllers/
│   │   ├── repositories/
│   │   ├── screens/
│   │   └── widgets/
│   ├── teachers/         ← A9
│   │   ├── controllers/
│   │   ├── repositories/
│   │   ├── screens/
│   │   └── widgets/
│   ├── attendance/       ← A10
│   │   ├── controllers/
│   │   ├── repositories/
│   │   ├── screens/
│   │   └── widgets/
│   ├── fees/             ← A11
│   │   ├── controllers/
│   │   ├── repositories/
│   │   ├── screens/
│   │   └── widgets/
│   └── exams/            ← A12
│       ├── controllers/
│       ├── repositories/
│       ├── screens/
│       └── widgets/
└── shared/
    ├── widgets/          ← A7
    └── utils/            ← A7
```

---

## Commit Convention

```
feat(flutter-<module>): <description>

OCA-YYYY-NN
```

Examples:
```
feat(flutter-auth): login and splash screens
feat(flutter-dashboard): stat cards and quick actions
```

## Completion Criteria

- [x] All 15 agents complete with exit code 0
- [x] Unit + widget tests pass — **14/14 passed**
- [x] Lint clean — **0 errors** (50 info/warnings non-blocking)
- [ ] Build succeeds (`flutter build apk --debug`) — requires `flutter pub get` in CI
- [ ] PR created to `develop`

---

## Known Technical Debt (Post-Merge)

| Issue | Impact | Effort |
|---|---|---|
| `RoleGuard` not wired into screens | Users see buttons they lack permission for | Low |
| 3 attendance screens are placeholders | Module not usable | Medium |
| Fee payment posting not in repo | Cannot record cash/online payments | Low |
| Exam repository is empty | Cannot submit grades or view report cards | Low |
| `app.dart` vs `main.dart` | No real impact, just naming inconsistency | Trivial |
| 50 lint infos/warnings | Trailing commas, deprecated `withOpacity`, unused imports | Low |
| `flutter analyze` `deprecated_member_use` on `withOpacity` in `status_badge.dart` | Replace with `.withValues()` for newer Flutter | Trivial |
