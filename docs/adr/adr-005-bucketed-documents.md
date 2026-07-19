# ADR-005: Bucketed Document Pattern for Time-Series Data

**Status:** Accepted  
**Date:** 2026-07-19  

## Context
Attendance, fee ledgers, and exam records grow unboundedly over time. MongoDB's 16MB document limit requires a strategy to prevent single documents from becoming too large.

## Decision
Use the bucketed document pattern: store time-series data in fixed-period buckets.

## Implementations
- **Attendance:** Monthly buckets per class (`monthYear: "2026-07"`)
- **FeeLedger:** Yearly buckets per student (`academicYear: "2026-2027"`)
- **ExamRecord:** Per-exam buckets per class (`examId` + `subjectName`)

## Consequences
- Document sizes remain predictable regardless of time range
- Queries map naturally to bucket boundaries (monthly sheets, yearly ledgers)
- Bucket merging/splitting may be needed if boundaries shift
