# ADR-001: Backend Framework — Node.js + Express

**Status:** Accepted  
**Date:** 2026-07-19  

## Context
The backend needs a runtime and framework to serve RESTful APIs for a madrasa management platform. Key requirements include async I/O, rapid development, and easy deployment.

## Decision
Use Node.js with Express.js framework.

## Consequences
- Express's middleware ecosystem enables clean separation of concerns (auth, validation, error handling)
- Large package ecosystem via npm accelerates development
- Vercel serverless deployment is supported natively
- JavaScript throughout the stack reduces context switching
