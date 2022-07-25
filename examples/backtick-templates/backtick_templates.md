# Backtick templates

The backtick templates consist of a tag followed by characters surrounded by backticks. They can contain expressions in `${...}` to be interpolated. If no escapes are recognized, use an expression to escape. They can contain new lines. Backtick templates are processed in the two phases below.
- Phase 1 does the tag-independent parse of which the result is a list of strings and expressions
- Phase 2 is tag-dependent

Phase 2 for `string...` converts expressions to strings and concatenates them. The `base16` and `base64` tags do not allow expressions.

::: code backtick_templates.bal :::

::: out backtick_templates.out :::