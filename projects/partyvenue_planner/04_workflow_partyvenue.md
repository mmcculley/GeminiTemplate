# Resilient Workflow

This document outlines the stateful, step-by-step process the agent must follow. This workflow is designed to be resilient, allowing the agent to recover from interruptions.

## 1. Understand and Plan

- **Orient to the Project:** Before analyzing the user's request, look for a `GEMINI.md` and `AGENTIC_HANDOFF.md` file in the root of the project. If they exist, read their contents to understand the project-specific conventions, build commands, and architecture. This context is crucial for all subsequent steps.
- **Analyze the Goal:** Fully parse the user's request, keeping the project context from the markdown files in mind.
- **Decompose into a Plan:** Break the task down into a sequence of discrete, ordered sub-tasks.

## 2. Initialize or Resume

- **Check for Existing Log:** Before starting, look for the `./agent_out_logs/` directory and its contents, specifically `progression_status.md` and `agent_state.json`.
- **Parse Log:** If the logs exist, parse them to determine the last successfully completed step.
- **Adjust Plan:** Modify the execution plan to skip all the steps that are already marked as complete. The agent will resume from the next incomplete step.
- **Log Resumption:** Before continuing, write a checkpoint entry in `progression_status.md`: `[RESTART] Resuming after failure at step: <X>. Verified existing file state.`

## 3. Execute and Log the Plan (Dual Logging)

For each step in the (potentially adjusted) plan, you will perform **dual logging** to maintain both human-readable and machine-readable records.

1. **Sanity Checks:** Before major steps, perform sanity checks as defined in `GEMINI.md`. If a check fails, log the error to `completion_summary.md` and halt.

2. **Log "STARTED":** Before executing any tool, you must log the start of the action in **both** places:
    - **Human Log:** Write a log entry to `progression_status.md` indicating the step is about to start.
    - **Machine Log:** Append a new JSON object to `task_log.json` with the `status` field set to `"STARTED"`.

3. **Execute the Tool:** Run the tool required for the current step.

4. **Log "SUCCESS" or "FAILURE":** After execution, you must update the logs in **both** places:
    - **On Success:**
        - **Human Log:** Update `progression_status.md` and `scaffold_coverage.md`.
        - **Machine Log:** Update the corresponding entry in `task_log.json`, setting `status` to `"SUCCESS"` and recording the result.
    - **On Failure:**
        - **Human Log:** Update `progression_status.md` and `completion_summary.md` with the error.
        - **Machine Log:** Update the corresponding entry in `task_log.json`, setting `status` to `"FAILURE"` and recording the error message.
    - **Stateful Files:** Update `agent_state.json` and `file_fingerprints.json` after every meaningful block of work.

## 4. Finalize and Commit

- **Generate Final Output:** Once all steps are complete, synthesize the results and update all logs.
- **Final Checklist:** Confirm that all MVP files and folders from `AGENTIC_HANDOFF.md` exist.
- **Create Completion Flag:** If successful, write the `✔️ partyvenue_planner_scaffolding_complete.flag` file at the project root.
