# Backtick templates

The backtick templates consist of a tag followed by characters surrounded by backticks. They can contain
`expressions` in `${...}` to be interpolated. If no escapes are recognized: use an `expression` to escape.
They can contain newlines. <br></br>
Processed in two phases.
<ul>
<li>Phase 1 does tag-independent parse: result is a list of `strings` and `expressions`</li>
<li>Phase 2 is tag-dependent</li>
</ul>
//<br></br>
Phase 2 for `string...` converts `expressions` to `strings` and concatenates. `base16` and `base64`
tags do not allow `expressions`.

::: code backtick_templates.bal :::

::: out backtick_templates.out :::