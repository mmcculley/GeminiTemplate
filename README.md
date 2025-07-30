# Gemini Agentic Prompt Template

This repository provides a structured template for creating, managing, and verifying complex agentic prompts for Gemini. Using a modular approach, it helps in building maintainable, reusable, and effective prompts that can be automatically verified against a "golden record".

## The Core Idea: Build and Verify

This template separates the prompt creation process into two key stages:

1. **Modular Components:** The prompt is broken down into smaller, reusable markdown files located in `components/` and `examples/`. This allows for easy management and modification of the agent's persona, rules, and workflow.
2. **Assembly and Verification:** The `assemble_prompt.py` script reads a `config.json` file, assembles the components into a single, final prompt, and crucially, can **verify** it against a reference version stored in `reference_prompts/`.

This workflow ensures that any changes to the prompt components can be tested to ensure they produce the expected final `GEMINI.md` file, making the system robust and reliable.

## 🚀 The Workflow

1. **Define Components:** Create or modify the markdown files in `components/` (for shared, core instructions) and within specific `examples/` directories (for task-specific instructions).
2. **Configure:** Create a `config.json` inside a new `examples/` subdirectory. In this file, list the component files in the desired order.
3. **Create a Reference Prompt:** Manually assemble your desired final prompt and save it in the `reference_prompts/` directory with the name `[example_name]_GEMINI.md`. This is your "golden record".
4. **Assemble & Verify:** Use the `assemble_prompt.py` script to build the prompt from your config and verify that it matches your reference file.
5. **Deploy:** Once verified, you can use the same script to output the final prompt as `GEMINI.md` in your project's root.

## 📂 Directory Structure

```plaintext
.
├── README.md
├── assemble_prompt.py
├── components/
├── examples/
│   └── [your_task]/
│       └── config.json
└── reference_prompts/
    └── [your_task]_GEMINI.md
```

- **`components/`**: Contains the reusable, core building blocks of your prompt (e.g., persona, tools, generic workflow).
- **`examples/`**: Contains task-specific configurations and prompt components. Each subdirectory represents a unique agent or task.
- **`reference_prompts/`**: Stores the final, correct "golden record" prompts. The assembly script verifies against these files.
- **`assemble_prompt.py`**: The core script for building and verifying prompts.

## ⚙️ Assembling and Verifying Prompts

The `assemble_prompt.py` script is the engine of this template. It ensures your prompts are built correctly.

### How it Works

The script reads a `config.json` file, concatenates the component files listed inside it, and then performs one of the following actions:

- **Verify:** Compares the generated prompt against the corresponding file in `reference_prompts/`.
- **Output:** Writes the generated prompt to a specified file path (e.g., `GEMINI.md`) or to `prompt.md` by default.

### Usage

Run the script from the project root. All paths in `config.json` must be relative to the root.

**1. Verify an existing example:**

```bash
# Verify the partyvenue_planner prompt
python assemble_prompt.py examples/partyvenue_planner/config.json --verify
```

> ✅ SUCCESS: Assembled prompt matches the reference file...

**2. Build a final `GEMINI.md` for deployment:**

```bash
# Build the prompt and output it to the root GEMINI.md
python assemble_prompt.py examples/partyvenue_planner/config.json --output GEMINI.md
```

> Successfully assembled prompt at GEMINI.md

### Script Arguments

| Argument | Short | Description |
|---|---|---|
| `config_path` | | (Required) Path to the `config.json` file. |
| `--output` | `-o` | (Optional) Path to the output file. Defaults to `prompt.md` in the config's directory. |
| `--verify` | `-v` | (Optional) Verify the output against the corresponding file in `reference_prompts/`. |

## 🛡️ Stateful Logging and Recovery

For complex, multi-step tasks, it is critical that the agent can recover from interruptions. This template implements a **stateful logging system** to ensure resilience. The full specification for this process is detailed in `components/04_workflow.md` and `components/06_logging.md`.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
