# ADR-004: Frontend Framework — Flutter with Riverpod

**Status:** Accepted  
**Date:** 2026-07-19  

## Context
The frontend requires cross-platform (Android, iOS, Web) support with complex state management.

## Decision
Use Flutter with Riverpod for state management and GoRouter for navigation.

## Consequences
- Single codebase for Android, iOS, and Web targeting
- Riverpod provides compile-time safety and testability for state management
- GoRouter enables declarative routing with auth redirects
- Freezed + json_serializable for immutable data models
- Larger binary size compared to native alternatives
