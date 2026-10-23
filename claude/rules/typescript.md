---
paths:
  - "**/*.{ts,tsx}"
---

# TypeScript

Personal defaults. Where a codebase has its own linter, formatter or
consistent conventions, follow those instead. Formatting is left to the
formatter.

## Type stripping
All code must work with Node type stripping (`erasableSyntaxOnly`): no
`enum`, `namespace`, parameter properties or `import x = require()`.

## Compiler
- `strict`, plus `noUncheckedIndexedAccess`, `noImplicitOverride`,
  `noFallthroughCasesInSwitch`, `erasableSyntaxOnly` and
  `verbatimModuleSyntax`.
- Leave `exactOptionalPropertyTypes` off.

## Imports and exports
- Put `import type` lines first, then all other imports.
- Named exports only. Default exports only where a framework requires them.
- No barrel files. Import directly from the file. Packages expose entry
  points through `package.json` `exports`.

## Types
- `interface` for object shapes that are extended or implemented, including
  props that extend a base (`interface ButtonProps extends ComponentProps<'button'>`).
- `type` for everything else: one-off shapes, plain props, unions and
  mapped or utility types.
- No `I` or `T` prefixes on type names. Use `T` for a single generic and
  `TName` when there are several.
- Use `undefined` and optional properties (`?`) for "no value". Use `null`
  only where an external contract needs it (JSON APIs, database columns).
- Never use `any`. Use `unknown` and narrow it, and validate external data
  at the boundary.
- Avoid `as` and `!`. When one is needed, add a one-line comment saying why.

## Fixed sets of values
- Use a string literal union by default: `type Status = 'pending' | 'active'`.
- Use an `as const` object when values are needed at runtime:

      const Direction = { Up: 0, Down: 1 } as const;
      type Direction = (typeof Direction)[keyof typeof Direction];

- For bit flags, use an `as const` object with `1 << n` values, and type
  combined flags as `number`.

## Variants
- Put shared fields on a base `interface`. Each variant extends it with a
  literal `type` field and is joined in a union.
- Handle unions with an exhaustive `switch` and a `never` check in `default`.

## Naming
- `SCREAMING_CASE` for global or module-level constants.
- PascalCase for `as const` object keys (`Status.Active`).

## Functions
- Use function declarations for named functions and React components.
  Use arrow functions for callbacks and inline functions.
- Annotate return types on named functions. Leave callbacks inferred.
- Functions over classes. Pass the data struct as the first argument
  (`updateSprite(sprite, dt)`).
- Keep functions pure: don't change inputs unless that's the explicit goal.
  Mark inputs `readonly` to show this.
- Consider an options object once there are more than 3 parameters.
  Use judgement; it's not a hard rule.

## Classes
- Use them only for real state and a lifecycle, or when a framework expects one.
- Use the `private` and `readonly` keywords with fields declared explicitly.
  No parameter properties.
- Order members: fields, then constructor, then methods.

## Data and iteration
- Prefer `const` over `let`.
- `for...of` by default, especially when one pass does the job of a chain.
- Use `map` or `filter` for a single simple transform. Avoid long chains,
  clever `reduce` calls and `forEach`.

## Errors
- Throw `Error` subclasses for unexpected errors. Never throw strings.
- Return a `Result` for expected failures the caller should handle.

## Async
- Always use `async`/`await`. Use `Promise.all` for independent work.
- No floating promises. Mark fire-and-forget calls with `void`.
