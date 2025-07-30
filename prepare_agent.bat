@echo off
SETLOCAL

REM ---
REM prepare_agent.bat: Generates all necessary files for an agent to start a task.
REM
REM This script runs a two-stage process:
REM 1. It generates the project blueprint (AGENTIC_HANDOFF.md) using the Spec Writer agent config.
REM 2. It generates the agent's final instructions (GEMINI.md) using the project-specific config.
REM ---

REM --- Configuration and Input Validation ---
SET PROJECT_NAME=%1
IF "%PROJECT_NAME%"=="" (
    echo Error: Please provide a project name from the 'examples' directory.
    echo Usage: prepare_agent.bat [project_name]
    exit /b 1
)

SET SPEC_CONFIG=examples\spec_writer\config.json
SET SCAFFOLD_CONFIG=examples\%PROJECT_NAME%\config.json

IF NOT EXIST %SCAFFOLD_CONFIG% (
    echo Error: The project '%PROJECT_NAME%' does not exist or has no config.json.
    exit /b 1
)

echo.
echo [1/2] Generating Project Blueprint (AGENTIC_HANDOFF.md)...
echo.

REM --- Generate the AGENTIC_HANDOFF.md file ---
python assemble_prompt.py %SPEC_CONFIG% --output AGENTIC_HANDOFF.md
IF errorlevel 1 (
    echo FAILED to generate AGENTIC_HANDOFF.md.
    exit /b 1
)
echo Successfully created AGENTIC_HANDOFF.md

echo.
echo [2/2] Generating Agent Instructions (GEMINI.md)...
echo.

REM --- Generate the GEMINI.md file ---
python assemble_prompt.py %SCAFFOLD_CONFIG% --output GEMINI.md
IF errorlevel 1 (
    echo FAILED to generate GEMINI.md.
    exit /b 1
)
echo Successfully created GEMINI.md

echo.
echo ---
echo ✅ Agent preparation complete for project: %PROJECT_NAME%
echo You can now run the agent using the generated GEMINI.md file.
echo ---

ENDLOCAL
