# MadrasaPulse Monorepo 🕌

Welcome to the **MadrasaPulse** repository. This is a mobile-first, modular madrasa management platform designed to handle entire institutional operations from a phone.

This repository is configured as a monorepo containing both the Flutter mobile client application and the Node.js Express server backend service.

---

## 📂 Repository Structure

*   **[`/backend/`](file:///d:/MadrasaPulse/backend/)** — Express.js REST API service using MongoDB and Mongoose.
*   **[`/frontend/`](file:///d:/MadrasaPulse/frontend/)** — Flutter mobile application (Riverpod state management, GoRouter, Dio).
*   **[`/docs/`](file:///d:/MadrasaPulse/docs/)** — Offline specifications:
    *   **[`system_specifications.md`](file:///d:/MadrasaPulse/docs/system_specifications.md)** — Master technical spec including database schema.
    *   **[`research_notes.md`](file:///d:/MadrasaPulse/docs/research_notes.md)** — Notion index map and free resources deployment guide.
    *   **[`changelog.md`](file:///d:/MadrasaPulse/docs/changelog.md)** — Version release log ledgers.
    *   **[`agents/`](file:///d:/MadrasaPulse/docs/agents/)** — Multi-agent supervisor guidelines and development plans.

---

## 🛠️ Tech Stack & Architecture

### Backend
*   **Engine:** Node.js, Express.js REST APIs
*   **Database:** MongoDB with Mongoose ODM
*   **Capping & Scaling:** Implements monthly class attendance buckets, yearly student invoice ledgers, and class-level exam sheets to prevent 16MB document size caps.
*   **Security:** Role-Based Access Control (RBAC) middleware verifying JWT tokens containing tenant `madrasaId`.

### Frontend
*   **Framework:** Flutter (Android & iOS)
*   **State Management:** Flutter Riverpod
*   **Network Layer:** Dio with custom interceptors for JWT access/refresh token rotation.

---

## 🚀 Getting Started & Testing

### Prerequisites
*   Node.js (v18 or higher)
*   Flutter SDK (v3.19 or higher)
*   MongoDB (local or MongoDB Atlas M0 cluster)

### Local API Verification
1.  Navigate to `/backend`, install dependencies, copy environment variables, and start:
    ```bash
    cd backend
    npm install
    npm start
    ```
2.  Run the integration test suite (22 E2E REST checks validating auth, student CRM, monthly attendance sheets, fee billing, and exams report cards):
    ```bash
    npm test
    ```

### Local Mobile Verification
1.  Navigate to `/frontend`, fetch Flutter pub packages, and run tests:
    ```bash
    cd frontend
    flutter pub get
    flutter test
    ```
2.  Analyze code quality (must output `No issues found!`):
    ```bash
    flutter analyze
    ```

---

## ☁️ Vercel Deployment

The backend API is configured to run as Serverless Node.js functions on Vercel:
1.  Install Vercel CLI or connect your GitHub repository to Vercel.
2.  In the project dashboard, select this repository and use **Other** preset.
3.  Add the environment variable `MONGODB_URI` pointing to your MongoDB Atlas connection string.
4.  Vercel will build the server using the configuration inside **[`vercel.json`](file:///d:/MadrasaPulse/vercel.json)**, exposing endpoints at `/api/v1/*`.

