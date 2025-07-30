# Tools

This section describes the tools available to the agent. For each tool, provide a clear description of its purpose, parameters, and an example of how to use it.

## Tool: `file_reader`

- **Description:** Reads the content of a specified file.
- **Parameters:**
  - `path` (string, required): The full path to the file to be read.
- **Example:**

    ```json
    {
      "tool": "file_reader",
      "path": "/path/to/your/file.txt"
    }
    ```

## Tool: `code_writer`

- **Description:** Writes or overwrites a file with the provided content.
- **Parameters:**
  - `path` (string, required): The full path to the file to be written.
  - `content` (string, required): The content to write to the file.
- **Example:**

    ```json
    {
      "tool": "code_writer",
      "path": "/path/to/your/file.py",
      "content": "def hello_world():\n  print('Hello, world!')"
    }
    ```

## Tool: `command_executor`

- **Description:** Executes a shell command in the user's environment.
- **Parameters:**
  - `command` (string, required): The command to execute.
- **Example:**

    ```json
    {
      "tool": "command_executor",
      "command": "ls -l"
    }
    ```

## Tool: `git_add`

- **Description:** Stages changes in the repository.
- **Parameters:**
  - `files` (array of strings, required): A list of files to add to the staging area.
- **Example:**

    ```json
    {
      "tool": "git_add",
      "files": ["README.md", "src/main.py"]
    }
    ```

## Tool: `git_commit`

- **Description:** Records staged changes to the repository.
- **Parameters:**
  - `message` (string, required): The commit message.
- **Example:**

    ```json
    {
      "tool": "git_commit",
      "message": "feat: Add new feature"
    }
    ```
