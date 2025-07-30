# Rules

## Project Requirements

- **Frontend:** React + Shoelace + Tailwind
- **Backend:** Node.js + Express
- **Database:** PostgreSQL
- **Deployment:** Docker + Podman

## Folder Structure

You must create the following folder structure:

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
└── agent_out_logs/
```

## Completion Flag

Upon successful completion of all scaffolding tasks, you must create a file named `✔️ partyvenue_planner_build_complete.flag` at the project root.

---

## Sanity Checks

Before executing the main scaffolding plan, you must verify the following conditions:

1. An `AGENTIC_HANDOFF.md` file exists in the project root. This file is the primary source of requirements for your task.
2. The `reference_prompts` directory exists. This is required to ensure the project structure is intact.

If any of these checks fail, you must immediately halt execution and report the missing file or directory in the `completion_summary.md` log before stopping.
