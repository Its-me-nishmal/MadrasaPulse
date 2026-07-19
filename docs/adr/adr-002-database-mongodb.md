# ADR-002: Database — MongoDB with Mongoose ODM

**Status:** Accepted  
**Date:** 2026-07-19  

## Context
The system needs to store semi-structured educational data (students, fees, attendance) with flexible schemas. Multi-tenancy and evolving requirements make rigid schemas undesirable.

## Decision
Use MongoDB as the primary database with Mongoose for schema validation and query building.

## Consequences
- Schema flexibility allows easy evolution of domain models
- Mongoose provides validation, middleware (pre-save hooks), and population
- 16MB document cap requires bucketed patterns for large datasets
- No built-in transactions across collections (mitigated by atomic operations)
