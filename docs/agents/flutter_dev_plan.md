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
| **A6 - Dashboard** | OCA-0719-06 | 2 | ⌛ Running | `features/dashboard/*` (4 files) | A3, A4 |
| **A7 - Shared Widgets** | OCA-0719-07 | 2 | ⌛ Running | `shared/widgets/*`, `shared/utils/*` (9 files) | A4 |
| **A8 - Students** | OCA-0719-08 | 3 | ⏳ Queued | `features/students/*` (8-10 files) | A3, A7 |
| **A9 - Teachers** | OCA-0719-09 | 3 | ⏳ Queued | `features/teachers/*` (7-9 files) | A3, A7 |
| **A10 - Attendance** | OCA-0719-10 | 3 | ⏳ Queued | `features/attendance/*` (7-9 files) | A3, A7 |
| **A11 - Fees** | OCA-0719-11 | 3 | ⏳ Queued | `features/fees/*` (7-9 files) | A3, A7 |
| **A12 - Exams** | OCA-0719-12 | 3 | ⏳ Queued | `features/exams/*` (6-8 files) | A3, A7 |
| **A13 - Tests** | OCA-0719-13 | 4 | ⏳ Queued | `test/**/*` (15-20 files) | All above |
| **A14 - West Fix** | OCA-0719-14 | 4 | ⏳ Queued | Lint fixes | A13 |
| **A15 - Canaries** | OCA-0719-15 | 4 | ⏳ Queued | Validation tests | A14 |

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

- [ ] All 15 agents complete with exit code 0
- [ ] Unit + widget tests pass (`flutter test`)
- [ ] Lint clean (`flutter analyze` with 0 errors)
- [ ] Build succeeds (`flutter build apk --debug`)
- [ ] PR created to `develop`
