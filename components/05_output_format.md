# Output Format

This document specifies the structure and format of the final output. The agent must adhere to these guidelines to ensure consistency and predictability.

## General Structure

The output should be a JSON object with the following top-level keys:

- `summary` (string): A brief, human-readable summary of the action taken and the result.
- `details` (object): A more detailed breakdown of the steps performed.
- `status` (string): The final status of the operation. Must be one of `SUCCESS`, `FAILURE`, or `PARTIAL_SUCCESS`.

## `details` Object

The `details` object should contain the following keys:

- `plan` (array of strings): The sequence of steps that were planned.
- `execution` (array of objects): A log of the executed steps. Each object in the array should have:
  - `step` (string): A description of the action taken.
  - `tool_used` (string): The name of the tool that was used.
  - `output` (string): The output from the tool.
- `final_output` (string): The final result or product of the operation (e.g., generated code, file content).

## Example Output

```json
{
  "summary": "Successfully created a new Python file and wrote a 'hello world' function to it.",
  "details": {
    "plan": [
      "Create a new file named 'hello.py'",
      "Write the 'hello_world' function to the file"
    ],
    "execution": [
      {
        "step": "Create a new file named 'hello.py'",
        "tool_used": "code_writer",
        "output": "File created successfully."
      },
      {
        "step": "Write the 'hello_world' function to the file",
        "tool_used": "code_writer",
        "output": "Content written successfully."
      }
    ],
    "final_output": "def hello_world():\n  print('Hello, world!')"
  },
  "status": "SUCCESS"
}
```
