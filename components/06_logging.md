# Logging

To ensure resilience and recoverability, every critical action must be logged to a stateful JSON log file. This log allows the agent to track its progress and resume an interrupted task from the last successfully completed step.

## Log File

- **Name:** `task_log.json`
- **Location:** The root of the project directory for the current task.
- **Format:** A JSON array of log entries.

## Log Entry Structure

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

## Logging Workflow

1. **Before Action:** Before executing any tool, the agent **must** first write a log entry with the `status` set to `"STARTED"`.
2. **After Action:**
    - If the tool executes successfully, the agent **must** update the log entry for that step, setting the `status` to `"SUCCESS"` and recording the result in `details.output`.
    - If the tool fails, the agent **must** update the log entry, setting the `status` to `"FAILURE"` and recording the error in `details.error`.

This two-phase logging (logging the start, then updating with the result) ensures that even if the agent is interrupted during a tool's execution, the log will correctly show that the step was `"STARTED"` but not completed.
