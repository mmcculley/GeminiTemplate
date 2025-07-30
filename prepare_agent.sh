#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# ---
# prepare_agent.sh: Generates all necessary files for an agent to start a task.
#
# This script runs a two-stage process:
# 1. It generates the project blueprint (AGENTIC_HANDOFF.md).
# 2. It generates the agent's final instructions (GEMINI.md) using a specific project recipe.
# ---

# --- Configuration and Input Validation ---
PROJECT_NAME=$1
RECIPE_NAME=$2
if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: Please provide a project name from the 'projects' directory."
    echo "Usage: ./prepare_agent.sh [project_name] [recipe_name]"
    exit 1
fi
if [[ -z "$RECIPE_NAME" ]]; then
    echo "Error: Please provide a recipe name (e.g., scaffold, add_feature)."
    echo "Usage: ./prepare_agent.sh [project_name] [recipe_name]"
    exit 1
fi

SPEC_CONFIG="meta/spec_writer/config.json"
PROJECT_CONFIG="projects/$PROJECT_NAME/config_$RECIPE_NAME.json"

if [[ ! -f "$PROJECT_CONFIG" ]]; then
    echo "Error: The recipe 'projects/$PROJECT_NAME/config_$RECIPE_NAME.json' was not found."
    exit 1
fi

echo ""
echo "[1/2] Generating Project Blueprint (AGENTIC_HANDOFF.md)..."
echo ""

# --- Generate the AGENTIC_HANDOFF.md file ---
python3 assemble_prompt.py "$SPEC_CONFIG" --output AGENTIC_HANDOFF.md
echo "Successfully created AGENTIC_HANDOFF.md"

echo ""
echo "[2/2] Generating Agent Instructions (GEMINI.md) using '$RECIPE_NAME' recipe..."
echo ""

# --- Generate the GEMINI.md file ---
python3 assemble_prompt.py "$PROJECT_CONFIG" --output GEMINI.md
echo "Successfully created GEMINI.md"

echo ""
echo "---"
echo "✅ Agent preparation complete for project: $PROJECT_NAME"
echo "You can now run the agent using the generated GEMINI.md file."
echo "---"
