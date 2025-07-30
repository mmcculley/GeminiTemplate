# Logging (Dual System)

To ensure maximum resilience and observability, this project uses a dual logging system. Every critical action must be logged to **both** a human-readable directory of files and a machine-readable JSON log.

---

## 1. Human-Readable Logs (`agent_out_logs/`)

This directory provides a high-level, easily reviewable summary of the agent's progress and state.

### Log Directory

- **Name:** `agent_out_logs/`
- **Location:** The root of the project directory for the current task.

#### Log Files

| Filename | Purpose |
| :--- | :--- |
| `completion_summary.md` | Summary of the current run’s scaffold or changes. |
| `agent_state.json` | The agent's current state, including decisions and focus. |
| `file_fingerprints.json` | Hashes or identifiers of all created/edited files. |
| `scaffold_coverage.md` | A summary of which handoff requirements are complete. |
| `progression_status.md` | A timeline or step-by-step log of progression. |

---

### 2. Machine-Readable Log (`task_log.json`)

This file provides a detailed, structured log suitable for automated parsing and resumption.

#### Log File

- **Name:** `task_log.json`
- **Location:** The root of the project directory for the current task.
- **Format:** A JSON array of log entries.

#### Log Entry Structure

Each entry in the log must be a JSON object with the following structure:

```json
{
  "timestamp": "YYYY-MM-DDTHH:MM:SS.sssZ",
  "step": "A human-readable description of the action being performed.",
  "tool": "The name of the tool being used for this step (e.g., 'code_writer', 'command_executor').",
  "status": "The current status of the step. Must be one of: 'STARTED', 'SUCCESS', 'FAILURE'.",
  "details": {
    "input": "The parameters or inputs provided to the tool.",
    "output": "The result from the tool (on SUCCESS).",
    "error": "The error message (on FAILURE)."
  }
}
```

---

*The workflow component will specify exactly when and how to write to each of these logs.*
