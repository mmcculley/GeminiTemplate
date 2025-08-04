import json
import os
import argparse
import sys
from jinja2 import Environment, FileSystemLoader
from jsonschema import validate, exceptions

def validate_config(config, schema):
    """Validates the configuration against the schema."""
    try:
        validate(instance=config, schema=schema)
    except exceptions.ValidationError as e:
        print(f"Error: Configuration file is invalid.", file=sys.stderr)
        print(f"Validation Error: {e.message} in {e.path}", file=sys.stderr)
        sys.exit(1)

def assemble_prompt(config_path, schema_path, output_path=None, verify=False):
    """
    Assembles a prompt from a config.json file, with schema validation and templating.
    """
    project_root = os.getcwd()
    config_path = os.path.join(project_root, config_path)
    base_dir = os.path.dirname(config_path)

    # Load Schema
    try:
        with open(schema_path, 'r', encoding="utf-8") as f:
            schema = json.load(f)
    except FileNotFoundError:
        print(f"Error: Schema file not found at {schema_path}", file=sys.stderr)
        sys.exit(1)

    # Load and Validate Config
    try:
        with open(config_path, 'r', encoding="utf-8") as f:
            config = json.load(f)
    except FileNotFoundError:
        print(f"Error: Configuration file not found at {config_path}", file=sys.stderr)
        sys.exit(1)
    validate_config(config, schema)

    # Setup Jinja2 Environment
    env = Environment(loader=FileSystemLoader(project_root), trim_blocks=True, lstrip_blocks=True)
    
    variables = config.get("variables", {})
    
    prompt_parts = []
    for component_path in config["components"]:
        if not os.path.exists(os.path.join(project_root, component_path)):
            print(f"Error: Component file not found at {component_path}", file=sys.stderr)
            sys.exit(1)
        template = env.get_template(component_path)
        rendered_component = template.render(variables)
        prompt_parts.append(rendered_component)

    if "task_prompt" in config:
        template = env.from_string(config["task_prompt"])
        rendered_task = template.render(variables)
        prompt_parts.append(rendered_task)

    final_prompt = "\n\n---\n\n".join(prompt_parts)

    if verify:
        reference_prompt_path = os.path.join(project_root, "reference_prompts", os.path.basename(base_dir) + "_GEMINI.md")
        if not os.path.exists(reference_prompt_path):
            print(f"Error: Verification file not found at {reference_prompt_path}", file=sys.stderr)
            sys.exit(1)
        
        with open(reference_prompt_path, 'r', encoding="utf-8") as f:
            reference_prompt_template = env.from_string(f.read())
            reference_prompt = reference_prompt_template.render(variables)

        if final_prompt.strip() == reference_prompt.strip():
            print(f"✅ SUCCESS: Assembled prompt matches the rendered reference file at {reference_prompt_path}")
        else:
            print(f"❌ FAILURE: Assembled prompt does not match the rendered reference file at {reference_prompt_path}", file=sys.stderr)
            sys.exit(1)
        return # Verification doesn't write a file

    # Determine output path
    if output_path:
        final_output_path = output_path
    else:
        final_output_path = os.path.join(base_dir, "prompt.md")

    output_dir = os.path.dirname(final_output_path)
    if output_dir:
        os.makedirs(output_dir, exist_ok=True)
    with open(final_output_path, 'w', encoding="utf-8") as f:
        f.write(final_prompt)
    print(f"Successfully assembled prompt at {final_output_path}")

def interactive_mode():
    """Guides the user through an interactive session."""
    project_root = os.getcwd()
    projects_dir = os.path.join(project_root, "projects")
    
    print("Welcome to the Interactive Prompt Assembler!")
    
    # Find available projects
    try:
        projects = [d for d in os.listdir(projects_dir) if os.path.isdir(os.path.join(projects_dir, d))]
        if not projects:
            print("No projects found in the 'projects/' directory.")
            return
    except FileNotFoundError:
        print("Error: The 'projects/' directory does not exist.")
        return

    # Let user choose an project
    print("\nPlease select a prompt to work with:")
    for i, project_name in enumerate(projects):
        print(f"  {i + 1}: {project_name}")
    
    choice = input(f"Enter number (1-{len(projects)}): ")
    try:
        selected_index = int(choice) - 1
        if not 0 <= selected_index < len(projects):
            raise ValueError()
        selected_project = projects[selected_index]
    except (ValueError, IndexError):
        print("Invalid selection.")
        return
        
    config_path = os.path.join("projects", selected_project, "config.json")

    schema_path = "config.schema.json"

    # Let user choose an action
    print(f"\nWhat would you like to do with '{selected_project}'?")
    print("  1: Verify against reference prompt")
    print("  2: Build to GEMINI.md in the project root")
    print("  3: Build to a custom file path")
    
    action_choice = input("Enter number (1-3): ")

    if action_choice == '1':
        assemble_prompt(config_path, schema_path, verify=True)
    elif action_choice == '2':
        assemble_prompt(config_path, schema_path, output_path="GEMINI.md")
    elif action_choice == '3':
        custom_path = input("Enter the full output file path: ")
        assemble_prompt(config_path, schema_path, output_path=custom_path)
    else:
        print("Invalid action.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Assemble and verify agentic prompts.",
        formatter_class=argparse.RawTextHelpFormatter
    )
    parser.add_argument(
        "config_path", 
        nargs='?', 
        default=None,
        help="Path to the config.json file (relative to project root)."
    )
    parser.add_argument(
        "--output",
        "-o",
        help="Path to the output file. Defaults to 'prompt.md' in the config file's directory."
    )
    parser.add_argument(
        "--verify",
        "-v",
        action="store_true",
        help="Verify the assembled prompt against the corresponding file in 'reference_prompts/'."
    )
    parser.add_argument(
        "--interactive",
        "-i",
        action="store_true",
        help="Run the script in interactive mode."
    )
    
    args = parser.parse_args()

    if args.interactive:
        interactive_mode()
    elif args.config_path:
        assemble_prompt(args.config_path, "config.schema.json", args.output, args.verify)
    else:
        parser.print_help()
