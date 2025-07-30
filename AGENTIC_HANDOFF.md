# 📋 AGENTIC HANDOFF – Project: PartyVenue Planner

## 1. Project Overview

PartyVenue Planner is a modular event management web application designed to streamline the process of planning and managing events. It provides a user-friendly interface for hosts to create events, manage guest lists, and track RSVPs, and for guests to easily respond to invitations.

## 2. High-Level Requirements

- **Frontend:** React + Shoelace
- **Backend:** Node.js + Express
- **Database:** PostgreSQL
- **Deployment:** Docker + Podman

## 3. File Manifest

```tree
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

## 4. API Endpoint Definitions

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/events` | Creates a new event. |
| `GET` | `/api/events` | Retrieves a list of all events. |
| `GET` | `/api/events/:id` | Retrieves details for a specific event. |
| `PUT` | `/api/events/:id` | Updates an existing event. |
| `DELETE` | `/api/events/:id` | Deletes an event. |
| `POST` | `/api/events/:id/rsvps` | Submits an RSVP for an event. |
| `GET` | `/api/events/:id/rsvps` | Retrieves all RSVPs for an event. |

## 5. UX Flow Descriptions

### Guest RSVP Flow
- The user receives a unique link to the event's RSVP page.
- The page displays event details (name, date, location) and a form to enter their name, email, and attendance status.
- Upon submission, the user sees a confirmation message and receives a confirmation email.

### Host Dashboard Layout
- After logging in, the host sees a dashboard with a list of their created events.
- Each event card shows the event name, date, and a summary of RSVP counts (Attending, Maybe, Not Attending).
- There is a prominent "Create New Event" button.

### Event Builder Wizard
- A multi-step wizard guides the host through creating a new event.
- **Step 1:** Basic Info (Event Name, Date, Time, Location).
- **Step 2:** Details (Description, Dress Code).
- **Step 3:** RSVP Options (Collect names, meal choices, etc.).
- **Step 4:** Review and Confirm.

### Check-in Screen
- A simple interface for hosts to check in guests on the day of the event.
- It features a search bar to find guests by name and a button to mark them as "Checked-in".
