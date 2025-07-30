#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# ---
# prepare_agent.sh: Generates all necessary files for an agent to start a task.
#
# This script runs a two-stage process:
# 1. It generates the project blueprint (AGENTIC_HANDOFF.md) using the Spec Writer agent config.
# 2. It generates the agent's final instructions (GEMINI.md) using the project-specific config.
# ---

# --- Configuration and Input Validation ---
PROJECT_NAME=$1
if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: Please provide a project name from the 'examples' directory."
    echo "Usage: ./prepare_agent.sh [project_name]"
    exit 1
fi

SPEC_CONFIG="examples/spec_writer/config.json"
SCAFFOLD_CONFIG="examples/$PROJECT_NAME/config.json"

if [[ ! -f "$SCAFFOLD_CONFIG" ]]; then
    echo "Error: The project '$PROJECT_NAME' does not exist or has no config.json."
    exit 1
fi

echo ""
echo "[1/2] Generating Project Blueprint (AGENTIC_HANDOFF.md)..."
echo ""

# --- Generate the AGENTIC_HANDOFF.md file ---
python3 assemble_prompt.py "$SPEC_CONFIG" --output AGENTIC_HANDOFF.md
echo "Successfully created AGENTIC_HANDOFF.md"

echo ""
echo "[2/2] Generating Agent Instructions (GEMINI.md)..."
echo ""

# --- Generate the GEMINI.md file ---
python3 assemble_prompt.py "$SCAFFOLD_CONFIG" --output GEMINI.md
echo "Successfully created GEMINI.md"

echo ""
echo "---"
echo "✅ Agent preparation complete for project: $PROJECT_NAME"
echo "You can now run the agent using the generated GEMINI.md file."
echo "---"
