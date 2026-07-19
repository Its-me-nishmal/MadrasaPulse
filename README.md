# MadrasaPulse Monorepo

Welcome to the MadrasaPulse repository. This repository is configured as a monorepo containing both the Flutter frontend application and the Node.js Express backend service.

---

## 📂 Repository Structure

*   `/.github/workflows/` — Automated CI/CD pipelines.
*   `/backend/` — Express.js REST API service using MongoDB.
*   `/frontend/` — Flutter mobile application.
*   `/docs/` — System specifications, PRDs, database design, and changelogs.

---

## 🛠️ Getting Started

### Prerequisites
*   Node.js (v18 or higher)
*   npm (v9 or higher)
*   Flutter SDK (v3.19 or higher)
*   MongoDB (local instance or MongoDB Atlas)

### Local Backend Setup
1. Navigate to `/backend`:
   ```bash
   cd backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Copy the `.env.example` file to `.env` and fill in your local variables.
4. Run the backend service in development mode:
   ```bash
   npm run dev
   ```

### Local Frontend Setup
1. Navigate to `/frontend`:
   ```bash
   cd frontend
   ```
2. Get Flutter packages:
   ```bash
   flutter pub get
   ```
3. Run the mobile application:
   ```bash
   flutter run
   ```

---

## 📝 Coding & Commit Standards

We follow the **Conventional Commits** standard. Please ensure your commits prefix your changes with `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, or `chore:`.

All code updates must be logged into **[changelog.md](file:///d:/MadrasaPulse/docs/changelog.md)**.
