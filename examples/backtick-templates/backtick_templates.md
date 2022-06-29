# Backtick templates

The backtick templates consist of a tag followed by characters surrounded by backticks. They can contain expressions in `${...}` to be interpolated. If no escapes are recognized use an expression to escape. They can contain newlines. Backtick templates are processed in two phases,
- Phase 1 does tag-independent parse, where the result is a list of strings and expressions
- Phase 2 is tag-dependent

Phase 2 for `string...` converts expressions to strings and concatenates. `base16` and `base64` tags do not allow expressions.

::: code backtick_templates.bal :::

::: out backtick_templates.out :::