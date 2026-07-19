# ADR-006: Authorization — Role-Based Access Control with JWT

**Status:** Accepted  
**Date:** 2026-07-19  

## Context
The platform serves multiple user roles (SuperAdmin, MadrasaAdmin, Teacher, Parent, Student) with different access levels.

## Decision
Implement RBAC using JWT access/refresh token pairs with permission scopes embedded in tokens.

## Roles & Permissions
- **SuperAdmin:** Wildcard `*` — full access
- **MadrasaAdmin:** Full CRUD on all domain resources within their madrasa
- **Teacher:** Read students, read/write attendance and exams
- **Parent:** Read own children's data, pay fees
- **Student:** Read own profile, attendance, and exam results

## Consequences
- JWT is stateless — no server-side session storage needed
- Token refresh rotation improves security without sacrificing UX
- Permission checks are fine-grained via `requirePermission()` middleware
- Token revocation requires short access token expiry (15 min) with refresh rotation
