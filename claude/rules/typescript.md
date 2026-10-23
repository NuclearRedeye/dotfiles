---
paths:
  - "**/*.{ts,tsx}"
---

# TypeScript

Personal defaults; a codebase's own conventions and linters win.

## General
- Code must work with type stripping: no `enum`, `namespace`, parameter
  properties or `import x = require()`.
- tsconfig: `strict`, `noUncheckedIndexedAccess`, `noImplicitOverride`,
  `noFallthroughCasesInSwitch`, `erasableSyntaxOnly`, `verbatimModuleSyntax`.
  Not `exactOptionalPropertyTypes`.
- `import type` lines first. Named exports only, unless a framework needs a
  default. No barrel files.

## Types
- `interface` when extended or implemented (including props with a base);
  `type` for everything else.
- No `I`/`T` prefixes. Generics: `T`, or `TName` when there are several.
- `undefined` and `?` for "no value"; `null` only for external contracts.
- No `any`: use `unknown` and narrow. Validate external data at the boundary.
- Avoid `as` and `!`; comment why when used.
- Fixed values: literal unions. Use an `as const` object when values are
  needed at runtime, with `1 << n` values for bit flags (combined as `number`).
- Variants: base `interface`, each variant adds a literal `type` field,
  joined in a union. Exhaustive `switch` with a `never` check.

## Naming
- `SCREAMING_CASE` for global or module-level constants; PascalCase for
  `as const` keys.

## Functions and classes
- Declarations for named functions and components; arrows for callbacks.
- Explicit return types on named functions; callbacks inferred.
- Functions over classes, with the data struct as the first argument.
- Pure: don't change inputs unless that's the goal; mark them `readonly`.
- Consider an options object past 3 parameters.
- Classes only for real state or when a framework expects one. Use
  `private`/`readonly` on fields declared explicitly. Order: fields,
  constructor, methods.

## Control flow
- `const` over `let`.
- `for...of` by default; `map`/`filter` for one simple transform. Avoid long
  chains, clever `reduce` and `forEach`.
- Throw `Error` subclasses for unexpected errors; return a `Result` for
  expected failures.
- `async`/`await` only. `Promise.all` for independent work. No floating
  promises; mark fire-and-forget with `void`.
