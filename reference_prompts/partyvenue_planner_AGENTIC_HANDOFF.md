
# 🟢 AGENTIC DEVELOPMENT HANDOFF – PROJECT: PartyVenue Planner

You are now responsible for scaffolding and initializing a modular web application called **PartyVenue Planner**.
This platform is designed for venues that host birthday parties, preschool playtimes, and wedding receptions.
It includes QR-based RSVP flows, guest registry integration, host dashboards, and staff coordination tools.

---

## 📘 Project Overview

**Frontend:** React + Shoelace + Tailwind  
**Backend:** Node.js + Express  
**Database:** PostgreSQL  
**Deployment:** Docker + Podman  
**Logging Folder:** `./agent_out_logs`

> All build logs, state files, and recovery documents must be stored in the `./agent_out_logs` directory.

---

## ✅ MVP Requirements

Full breakdown is in `/docs/MVP_Requirements.md`, including:

- Guest List Import
- Add-On Catalog
- Gift Registry Aggregator
- Parking & Directions Module
- Dietary Restrictions Input
- Calendar with Conflict Detection
- Check-In Mode
- Event Analytics Dashboard
- Weather Watcher
- Emergency Contact Logic
- Post-Event Feedback Collection

---

## 🗂️ Project Folder Structure

```plaintext
partyvenue-planner/
├── backend/
│   ├── src/
│   │   ├── controllers/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── models/
│   │   ├── middleware/
│   │   ├── utils/
│   │   └── index.js
│   └── .env.example
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── hooks/
│   │   ├── utils/
│   │   └── App.jsx
│   └── index.html
├── docker/
│   ├── Dockerfile.backend
│   ├── Dockerfile.frontend
│   └── nginx.conf
├── docs/
│   ├── UX/
│   │   ├── guest_rsvp_flow.md
│   │   ├── host_dashboard_layout.md
│   │   ├── event_builder_wizard.md
│   │   └── check_in_screen.md
│   └── MVP_Requirements.md
├── .env
├── docker-compose.yml
├── README.md
├── GEMINI.md
├── AGENTIC_HANDOFF.md
└── agent_out_logs/  <-- logging directory (MUST EXIST)
    ├── completion_summary.md
    ├── agent_state.json
    ├── file_fingerprints.json
    ├── scaffold_coverage.md
    └── progression_status.md
```

---

## ⚙️ Startup Instructions

### Frontend

```bash
cd frontend
npm install
npm run dev
```

### Backend

```bash
cd backend
npm install
npm run dev
```

### Docker Compose (Full Stack)

```bash
podman-compose up --build
```

### Env Example

```env
PORT=3001
DB_HOST=localhost
DB_USER=postgres
DB_PASS=postgres
DB_NAME=partyvenue
JWT_SECRET=devsecretkey
```

---

## 🧪 Initial Test Targets

### `/src/pages/Dashboard.jsx`

```jsx
export default function Dashboard() {
  return <h1>Welcome to PartyVenue Planner 🎉</h1>;
}
```

### `/src/index.js`

```js
const express = require('express');
const app = express();
app.get('/api/health', (req, res) => res.json({ status: 'OK' }));
app.listen(3001, () => console.log('Backend running on port 3001'));
```

### `docker-compose.yml`

```yaml
version: '3.8'

services:
  backend:
    build:
      context: ./backend
      dockerfile: ../docker/Dockerfile.backend
    ports:
      - "3001:3001"
    env_file:
      - .env
    volumes:
      - ./backend:/app

  frontend:
    build:
      context: ./frontend
      dockerfile: ../docker/Dockerfile.frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app

  db:
    image: postgres:14
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: partyvenue
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

---

## 🧠 GEMINI AGENT BEHAVIOR REQUIREMENTS

- Create and use `./agent_out_logs/` to store:
  - `completion_summary.md`
  - `agent_state.json`
  - `file_fingerprints.json`
  - `scaffold_coverage.md`
  - `progression_status.md`
- Resume from the last known point using `progression_status.md` and `agent_state.json`.
- Echo a checkpoint status after every major scaffold step.
- If interrupted or restarted, parse those files to determine next step before proceeding.

---

## ✅ Completion Flag

Write the following file at root to indicate project scaffold is complete:

```plaintext
✔️ partyvenue_planner_build_complete.flag
```
