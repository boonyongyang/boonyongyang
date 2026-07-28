# Workspace Agent Routing

This repository contains separate application surfaces. Confirm which surface a
task targets before editing files, and do not mix their architecture or
deployment configuration implicitly.

## Isolated Next.js 3D Portfolio

For any task involving `portfolio-3d-next/`, Three.js, React Three Fiber, the new
3D landing page, or its production release:

1. Read `portfolio-3d-next/AGENTS.md` completely.
2. Read `portfolio-3d-next/PRODUCTION-ROADMAP.md` completely.
3. Read `portfolio-3d-next/DELEGATION.md` before spawning or claiming work.
4. Claim the explicitly assigned roadmap task and follow its acceptance criteria.

A roadmap is not an automatic scheduler. Every delegated implementation prompt
must name a task ID. Do not let multiple agents independently choose whichever
task looks convenient.

The Next.js site is intentionally isolated from the existing Flutter landing
site. Do not point the root Firebase configuration, Flutter build scripts, or
existing deployment workflow at `portfolio-3d-next/out/` unless roadmap task
`R0-02` has selected that integration explicitly.

## Existing Flutter Surfaces

For Flutter landing-page or main-app work, use the existing project guides:

- `README.md`
- `DEPLOYMENT.md`
- `docs/STATUS.md`
- `docs/ROADMAP.md`
- `docs/landing/ARCHITECTURE.md`
- `docs/main_app/ARCHITECTURE.md`

Do not treat tasks in the Next.js production roadmap as changes requested for
the Flutter applications.

## Shared Safety

- Preserve unrelated user changes in the worktree.
- Keep generated build outputs out of version control.
- A passing local build is not proof of a successful public release.
- Record evidence before marking deployment or release tasks complete.
