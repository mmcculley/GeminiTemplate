# AGENTIC_HANDOFF.md Output Format

The output must be a single, comprehensive Markdown document named `AGENTIC_HANDOFF.md`. It must be structured precisely as follows, using the provided headings, tables, and code blocks.

---

# 📋 AGENTIC HANDOFF – Project: {{project_name}}

## 1. Project Overview

A brief, one-paragraph description of the application's purpose and its core value proposition.

## 2. High-Level Requirements

A bulleted list outlining the key technologies and platforms.
- **Frontend:** {{frontend_framework}}
- **Backend:** {{backend_framework}}
- **Database:** {{database}}
- **Deployment:** {{deployment_env}}

## 3. File Manifest

A complete list of all files and directories to be created. This must be presented in a single, collapsible code block with the `tree` language identifier.

```tree
{{project_name}}/
├── backend/
│   └── ... (full structure here)
├── frontend/
│   └── ... (full structure here)
└── ... (etc.)
```

## 4. API Endpoint Definitions

A Markdown table defining the required API endpoints for the backend.

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/events` | Creates a new event. |
| `GET` | `/api/events/:id` | Retrieves details for a specific event. |

## 5. UX Flow Descriptions

A section for each major user experience flow, with a level-3 heading for each.

### Guest RSVP Flow
- The user receives a link to the event.
- The user sees event details and an RSVP form.
- The user submits the form and sees a confirmation message.

---
*This document must be generated as the agent's single and final output.*
