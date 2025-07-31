#!/bin/bash
set -e

# ---
# update_docs.sh: Scans the projects and updates the README.md file.
# ---

echo ""
echo "📝 Updating documentation..."
echo ""

README_FILE="README.md"
TEMP_README="README.temp.md"

# --- Part 1: Generate the new projects list ---
PROJECTS_LIST_FILE="projects_list.tmp"
echo "## Available Projects" > "$PROJECTS_LIST_FILE"
echo "" >> "$PROJECTS_LIST_FILE"
echo "This framework currently manages the following projects and recipes:" >> "$PROJECTS_LIST_FILE"
echo "" >> "$PROJECTS_LIST_FILE"

for project in projects/*; do
  if [ -d "$project" ]; then
    project_name=$(basename "$project")
    echo "- **$project_name**" >> "$PROJECTS_LIST_FILE"
    for recipe_file in "$project"/config_*.json; do
      if [ -f "$recipe_file" ]; then
        recipe_name=$(basename "$recipe_file")
        recipe_name=${recipe_name#config_}
        recipe_name=${recipe_name%.json}
        echo "  - `$recipe_name`" >> "$PROJECTS_LIST_FILE"
      fi
    done
    echo "" >> "$PROJECTS_LIST_FILE"
  fi
done

# --- Part 2: Replace the old section in README.md ---
# This uses awk to find the start and end markers and replace the content between them.
awk '
  BEGIN { p = 1 }
  /^## Available Projects/ { print; system("cat projects_list.tmp"); p = 0 }
  /^---/ { p = 1 }
  p { print }
' "$README_FILE" > "$TEMP_README"


# --- Part 3: Clean up and replace ---
mv "$TEMP_README" "$README_FILE"
rm "$PROJECTS_LIST_FILE"

echo "✅ README.md has been successfully updated."
echo ""
