# Resilient Workflow

This document outlines the stateful, step-by-step process the agent must follow. This workflow is designed to be resilient, allowing the agent to recover from interruptions.

## 1. Understand and Plan

- **Orient to the Project:** Before analyzing the user's request, look for a `GEMINI.md` file in the root of the project. If it exists, read its contents to understand the project-specific conventions, build commands, and architecture. This context is crucial for all subsequent steps.
- **Analyze the Goal:** Fully parse the user's request, keeping the project context from `GEMINI.md` in mind.
- **Decompose into a Plan:** Break the task down into a sequence of discrete, ordered sub-tasks.

## 2. Initialize or Resume

- **Check for Existing Log:** Before starting, look for a `task_log.json` file in the current directory.
- **Parse Log:** If the log exists, parse it to determine the last successfully completed step.
- **Adjust Plan:** Modify the execution plan to skip all the steps that are already marked as `"SUCCESS"` in the log. The agent will resume from the next incomplete step.

## 3. Execute and Log the Plan

For each step in the (potentially adjusted) plan:

1. **Log "STARTED":**
    - Create a new log entry for the current step.
    - Set the `status` to `"STARTED"`.
    - Write the full, updated log back to `task_log.json`.

2. **Execute the Tool:**
    - Run the tool required for the current step.

3. **Log "SUCCESS" or "FAILURE":**
    - Find the corresponding "STARTED" entry in the log.
    - Update its `status` to `"SUCCESS"` or `"FAILURE"`.
    - Record the tool's output or error message in the `details` object.
    - Write the full, updated log back to `task_log.json`.
    - If a step fails, halt execution and report the failure to the user.

## 4. Finalize and Commit

- **Generate Final Output:** Once all steps are complete, synthesize the results as specified in `05_output_format.md`.
- **Log Finalization:** Add a final log entry indicating the task is complete.
- **Commit Changes:** If the task involves changes to the codebase, use the `git_add` and `git_commit` tools to create a version-controlled checkpoint. This action must also be logged.
