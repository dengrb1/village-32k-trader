# Repository Guidelines

## Project Structure & Module Organization

This repository is a Minecraft Java datapack for the `village_trader` namespace. Keep the datapack root flat: `pack.mcmeta` defines supported pack formats, and `data/` contains all runtime content.

- `data/minecraft/tags/function/load.json` registers the load entry point.
- `data/village_trader/function/` contains `.mcfunction` logic. `load.mcfunction` schedules `scan.mcfunction`; `create.mcfunction`, `build_house.mcfunction`, and `spawn_merchant.mcfunction` handle placement; `set_trades.mcfunction` defines offers.
- `data/village_trader/predicate/` holds JSON predicates used by functions.
- Root `.zip` files are distributable datapack archives. Update them only for intentional releases.

## Build, Test, and Development Commands

There is no build step or automated test command. Test changes in Minecraft Java 26.1.2:

1. Copy the repository folder to `<world>/datapacks/村庄32K商人/`.
2. Run `/reload` and confirm the green load message.
3. Enter a natural village and verify house creation, merchant spawning, and trades.
4. Run `/function village_trader:uninstall`, then `/reload`, to confirm scheduled work and tagged entities are cleaned up.

Before packaging, open the archive and confirm it contains `pack.mcmeta` and `data/` at its root—not an extra enclosing folder.

## Coding Style & Naming Conventions

Use two-space indentation for JSON and preserve the existing one-command-per-line style in `.mcfunction` files. Keep comments concise and, where user-facing, in Chinese to match the project documentation. Name function files with lowercase snake_case (for example, `spawn_merchant.mcfunction`) and reference them as `village_trader:spawn_merchant`. Use the `village_trader.` prefix for entity tags and stable, descriptive IDs for attribute modifiers.

## Testing Guidelines

Manually test every changed command in a disposable world. For trade changes, verify item IDs, component syntax, prices, and that the villager has all expected offers. For placement changes, test repeated village entry and confirm the 160-block marker guard prevents duplicate houses.

## Commit & Pull Request Guidelines

Recent history uses short, imperative Chinese release-oriented subjects, such as `支持 Minecraft Java 26.1.2`. Follow that style: state the user-visible change and target version when relevant. Keep commits focused. Pull requests should describe behavior changes, list tested Minecraft version and commands, link relevant issues, and include screenshots or short clips for visible house or trade changes.
