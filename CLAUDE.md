# CLAUDE.md — Global

Behavioral standards for all projects. Project CLAUDE.md adds context on top of this.

---

## 1. Think Before Coding

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- Stop when something is unclear. Name what's confusing. Ask.

## 2. Simplicity First

- No features beyond what was asked.
- No abstractions for single-use code. No "flexibility" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

- Touch only what the request requires.
- Don't improve adjacent code, comments, or formatting.
- Don't refactor things that aren't broken. Match existing style.
- Mention unrelated dead code — don't delete it unprompted.
- Remove imports/vars/functions only that YOUR changes made unused.

## 4. Goal-Driven Execution

- Transform tasks into verifiable goals before starting.
  - "Add validation" → "Write tests for invalid inputs, then make them pass"
  - "Fix the bug" → "Write a failing test, then make it pass"
- For multi-step tasks, state the plan first.

---

## 5. Production Standards

### Architecture
- Composition over inheritance.
- Dependency injection over singletons — singletons make testing impossible.
- Single responsibility per file: one type, one clear purpose.
- Every layer communicates through defined interfaces (protocols/types), not concrete dependencies.
- If you can't explain what a file does in one sentence, it's doing too much.

### Single Source of Truth
- State lives in exactly one place. ViewModels own state; Views read it.
- Never duplicate state between layers — derived data is computed, never stored.
- Constants and configuration live in one file — never spread across the codebase.
- If two pieces of code need the same value, one imports from the other. Never copy-paste.
- The database is the source of truth for persisted data. Local cache is a copy, treated as such.

### No Dead Code
- Delete unused code immediately — don't comment it out "just in case."
- Commented-out code is a lie: it implies something that isn't true about the program.
- Unused variables, imports, and conformances get removed — not left for later.
- If a function was needed for a feature that was cut, delete the function.
- `git` is version control — past code is always recoverable. Don't use comments as version control.

### No Duplicate Logic
- Every business rule exists in one place. If two files have similar logic, one of them is wrong.
- Don't copy-paste code between files — extract to a shared function or type.
- If you find yourself writing the same pattern twice, stop and build the abstraction first.
- Display/formatting logic lives in one helper, not re-implemented in each view.

### Error Handling
- Errors surface — never `print()` and swallow silently.
- Use typed errors (enums) not generic `Error`/`Exception`.
- Log context: what was being attempted, not just what failed.
- Propagate with `throws`/`Result`/`async throws` — don't convert errors to optionals.

### Scalability Checkpoints (before any new abstraction)
- Could this realistically need to change in the next 6 months? If no, don't abstract it.
- If you add a new abstraction, delete the code it replaced.
- Adding a protocol for a type with exactly one implementation is premature — wait for the second.
- A function longer than 40 lines is doing too many things. Split it.

### Testing
- Test behavior, not implementation. Tests should not break when internals are refactored.
- Mock at the boundary only — network, filesystem, database. Never mock internal types.
- If a test requires mocking 4+ things, the code under test is too coupled.

---

## 6. Working with Claude Code

### Context
- `/clear` between unrelated tasks — contaminated context causes subtle bugs.
- If I've corrected you twice on the same issue, `/clear` and write a better prompt. Never correct three times in one session.
- At 70% context: finish the current task. At 85%: compaction is imminent.

### Subagents
- **Code review**: always in a fresh session — zero attachment to code it wrote.
- **Security audit**: `@security-reviewer` agent, dedicated session, read-only tools.
- **Research**: background agent so it doesn't consume main context.
- **Parallel features**: worktrees + separate sessions, never the same branch.

### Before Declaring Done
- [ ] Code matches existing patterns in this codebase?
- [ ] Tests written and passing?
- [ ] No hardcoded values that should be config?
- [ ] No commented-out code?
- [ ] No new warnings or lint violations?
- [ ] No dead code introduced — every function, variable, and import is used?
