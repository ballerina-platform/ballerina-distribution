xml:Element e = xml`<p:e xmlns:p="http://example.com/"/>`;
// `name` will be `{http://example.com}e`.
string name = e.getName();
