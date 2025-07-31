#!/bin/bash
set -e

# ---
# init_project.sh: Creates the directory structure and boilerplate files for a new project.
# ---

NEW_PROJECT_NAME=$1
if [[ -z "$NEW_PROJECT_NAME" ]]; then
    echo "Error: Please provide a name for the new project."
    echo "Usage: ./init_project.sh [NewProjectName]"
    exit 1
fi

TEMPLATE_DIR="meta/project_initializer"
PROJECT_DIR="projects/$NEW_PROJECT_NAME"

echo ""
echo "🚀 Initializing new project: $NEW_PROJECT_NAME..."
echo ""

if [[ -d "$PROJECT_DIR" ]]; then
    echo "Error: A project named '$NEW_PROJECT_NAME' already exists."
    exit 1
fi

echo "Creating directory: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"

# --- Create config from template ---
CONFIG_TEMPLATE="$TEMPLATE_DIR/template_config.json"
NEW_CONFIG_FILE="$PROJECT_DIR/config_scaffold.json"
echo "Creating recipe: $NEW_CONFIG_FILE"
sed "s/{{PROJECT_NAME}}/$NEW_PROJECT_NAME/g" "$CONFIG_TEMPLATE" > "$NEW_CONFIG_FILE"

# --- Create rules from template ---
RULES_TEMPLATE="$TEMPLATE_DIR/template_rules.md"
NEW_RULES_FILE="$PROJECT_DIR/rules_scaffold.md"
echo "Creating rules: $NEW_RULES_FILE"
sed "s/{{PROJECT_NAME}}/$NEW_PROJECT_NAME/g" "$RULES_TEMPLATE" > "$NEW_RULES_FILE"


echo ""
echo "---"
echo "✅ Successfully initialized project: $NEW_PROJECT_NAME"
echo "You can now customize the recipe and rules in 'projects/$NEW_PROJECT_NAME'"
echo "---"
