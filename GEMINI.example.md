# Gemini Project Configuration (`GEMINI.md`)

## 1. Project Overview
<!-- 
A high-level summary of the project. What is its purpose? What problem does it solve? 
This helps the agent understand the "why" behind the code.
-->
**Purpose:** This project is a [Project Type, e.g., "REST API for a social media platform", "data processing pipeline", "React-based e-commerce frontend"]. Its primary goal is to [Primary Goal, e.g., "manage user profiles and posts", "transform raw log data into structured analytics", "allow users to browse and purchase products"].

**Key Technologies:**

- **Language:** [e.g., Python 3.9, TypeScript 4.8]
- **Framework/Runtime:** [e.g., FastAPI, Node.js v18, React 18]
- **Database:** [e.g., PostgreSQL, MongoDB, None]
- **Package Manager:** [e.g., pip, npm, yarn]

---

## 2. Project Structure & Architecture
<!--
Describe the layout of the repository. Where is the most important code? 
This is critical for helping the agent navigate the codebase efficiently.
-->
**Architecture Style:** [e.g., Monolithic, Microservices, Serverless]

**Key Directories:**

- `src/`: Contains the primary application source code.
  - `src/api/`: API endpoint definitions and routing.
  - `src/services/`: Business logic and core functionalities.
  - `src/models/`: Database models and schemas.
  - `src/utils/`: Shared utility functions.
- `tests/`: Contains all unit and integration tests.
- `docs/`: Project documentation.
- `scripts/`: Helper scripts for deployment, data migration, etc.
- `config/`: Configuration files for different environments.

---

## 3. Coding Conventions & Style Guide
<!--
Define the rules for code formatting and structure. This ensures the agent generates code that is consistent with the existing codebase.
-->
- **Formatting:** This project uses [e.g., "Black for Python", "Prettier for TypeScript"]. Please adhere to the configuration in `.prettierrc` / `pyproject.toml`.
- **Naming Conventions:**
  - Variables and functions: `snake_case`
  - Classes: `PascalCase`
  - Constants: `UPPER_SNAKE_CASE`
- **Comments:** Add docstrings to all public functions and classes. Use inline comments for complex or non-obvious logic.
- **Typing:** This project uses static typing. All new code should include type hints.

---

## 4. Local Development Setup & Commands
<!--
Provide the exact commands needed to set up, run, test, and build the project. This is one of the most important sections.
-->
**Setup:**

1. Install dependencies:

   ```bash
   npm install
   ```

2. Set up environment variables. Copy `.env.example` to `.env` and fill in the required values.

   ```bash
   cp .env.example .env
   ```

3. Initialize the database:

   ```bash
   npm run db:migrate
   ```

**Common Commands:**

- **Run the development server:**

  ```bash
  npm run dev
  ```

- **Run all tests:**

  ```bash
  npm run test
  ```

- **Run only specific tests:**

  ```bash
  npm test -- tests/services/test_user_service.spec.ts
  ```

- **Run the linter:**

  ```bash
  npm run lint
  ```

- **Build for production:**

  ```bash
  npm run build
  ```

---

## 5. Key APIs & Data Models
<!--
Describe the most important API endpoints or data structures. This helps the agent understand how different parts of the system interact.
-->
**User API (`/api/users`):**

- `GET /api/users/{id}`: Fetches a user by ID.
- `POST /api/users`: Creates a new user.
  - **Body:** `{ "username": "string", "email": "string" }`

**User Data Model:**

```typescript
interface User {
  id: number;
  username: string;
  email: string;
  createdAt: Date;
}
```

---

## 6. Important Notes & Gotchas
<!--
Is there anything unusual about this project the agent should know? Any common pitfalls or non-standard configurations?
-->
- **Authentication:** All API requests to `/api/private/*` must include an `Authorization: Bearer <token>` header. The token is a standard JWT.
- **Legacy Module:** The code in `src/legacy/` is deprecated and should not be modified. It is scheduled for removal in Q4.
- **Database Migrations:** Always generate a new migration file using `npm run db:generate-migration <name>` before making any schema changes. Do not edit the schema directly.
