# ADR-003: Multi-Tenancy Strategy — Shared Database with Tenant Isolation

**Status:** Accepted  
**Date:** 2026-07-19  

## Context
Multiple madrasa organizations will use the same application. Each tenant's data must be isolated.

## Decision
Use a single shared database with `madrasaId` field on every document for tenant isolation.

## Consequences
- Every query must include a `madrasaId` filter — enforced via middleware where possible
- Compound indexes always include `madrasaId` as the first field
- JWT tokens carry `madrasaId` claims for automatic context
- Simpler operations than dedicated databases per tenant
