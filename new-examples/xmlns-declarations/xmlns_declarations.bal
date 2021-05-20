// The identifier followed by the `as` keyword is the prefix bound
// to this namespace name.
xmlns "http://example.com" as eg;

xml x = xml`<eg:doc>Hello</eg:doc>`;

xmlns "http://example.com" as ex;

// `b` will be `true`.
boolean b = (x === x.<ex:doc>);

// `exdoc` will be `{http://example.com}doc`.
string exdoc = ex:doc;
