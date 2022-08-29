# Backtick templates

The backtick templates consist of a tag followed by characters surrounded by backticks. They can contain
`expressions` in `${...}` to be interpolated. If no escapes are recognized: use an `expression` to escape.

They can contain newlines and are processed in two phases.

1. Phase 1 does tag-independent parse: result is a list of `strings` and `expressions`
2. Phase 2 is tag-dependent: Phase 2 for `string...` converts `expressions` to `strings` and concatenates. `base16` and `base64` tags do not allow `expressions`.

::: code backtick_templates.bal :::

::: out backtick_templates.out :::