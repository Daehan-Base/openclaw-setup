# Coding Agent Guidance

- This repository is focused on installing OpenClaw on a VPS (primarily Ubuntu), setting up Telegram integration, and operating it as a long-running service.
- This file defines execution rules for the agent/Claude behavior in this repository.
- Keep changes minimal, keep scope explicit, and avoid unnecessary refactoring.
- Run commands from within the repository (the `./` directory) and explicitly document dependency changes.
- Perform testing or validation only when the user explicitly requests it.

## IMPORTANT
- Before proceeding with installation on a personal environment (local PC or personal account), confirm the user understands potential privacy and security implications.
- Do not ask users to paste credentials directly in chat (API keys, bot tokens, passwords, private keys, secrets).
- If credentials are required, guide users to use secure local methods (masked placeholders, environment variables, secret files, or equivalent secure secret-management paths) and never request or log real secret values.
