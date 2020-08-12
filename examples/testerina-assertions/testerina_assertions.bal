import ballerina/test;

type Person object {
    public string name = "";
    public int age = 0;
    public Person? parent = ();
    private string email = "default@abc.com";
    string address = "No 20, Palm grove";
};

// The `assertEquals()` function allows you to compare anydata type values for value equality.
// The `assertExactEquals()` function allows you to compare any type entries for exact equality.
// Compares values of the type `int`.
@test:Config {}
function testAssertIntEquals() {
    int answer = 0;
    int a = 5;
    int b = 3;
    answer = intAdd(a, b);
    test:assertEquals(answer, 8, msg = "int values not equal");
}

// Compares values of the type `float`.
@test:Config {}
function testAssertFloatEquals() {
    float a = 10.000;
    float b = 20.050;
    float answer = floatAdd(a, b);
    test:assertEquals(answer, 30.050, msg = "float values not equal");
}

// Compares values of the type `string`.
@test:Config {}
function testAssertStringEquals() {
    string a = "John";
    string b = "Doe";
    string concatenated = stringConcat(a, b);
    test:assertEquals(concatenated, "JohnDoe", msg = "string values not equal");
}

// Compares values of the type `json`.
@test:Config {}
function testAssertJsonEquals() {
    json a = {"name": "Ballerina"};
    json b = {"name": "Ballerina"};
    test:assertEquals(a, b, msg = "JSON values not equal");
}

// Compares values of the type `xml`.
@test:Config {}
function testAssertXmlEquals() {
    xml x1 = xml `<book>The Lost World</book>`;
    xml x2 = xml `Hello, world!`;
    xml x3 = xml `<!--I am a comment-->`;
    xml x4 = xml `<?target data?>`;
    xml x5 = x1 + x2 + x3 + x4;
    xml x6 = xml `<book>The Lost World</book>` + xml `Hello, world!` + xml `<!--I am a comment-->` + xml `<?target data?>`;
    test:assertEquals(x5, x6, msg = "XML values not equal");
}

// Compares values of the type `boolean`.
@test:Config {}
function testAssertBooleanEquals() {
    boolean x = true;
    boolean y = true;
    test:assertEquals(x, y, msg = "boolean values not equal");
}

// Compares values of the type `string[]`.
@test:Config {}
function testAssertStringArrayEquals() {
    string[] x = ["A", "B", "C"];
    string[] y = ["A", "B", "C"];
    test:assertEquals(x, y, msg = "string array values not equal");
}

// Compares values of the type `int[]`.
@test:Config {}
function testAssertIntArrayEquals() {
    int[] x = [1, 2, 3];
    int[] y = [1, 2, 3];
    test:assertEquals(x, y, msg = "int array values not equal");
}

// Compares values of the type `float[]`.
@test:Config {}
function testAssertFloatArrayEquals() {
    float[] x = [1.1, 2.2, 3.3];
    float[] y = [1.1, 2.2, 3.3];
    test:assertEquals(x, y, msg = "float array values not equal");
}

// Compares distinct values of the type `string`.
@test:Config {}
function testAssertNotEqualsString() {
    string s1 = "abc";
    string s2 = "def";
    test:assertNotEquals(s1, s2, msg = "string values are equal");
}

// Compares distinct values of the type `json`.
@test:Config {}
function testAssertNotEqualsJson() {
    json s1 = {"a": "b"};
    json s2 = {"a": "c"};
    test:assertNotEquals(s1, s2, msg = "JSON values are equal");
}

// Compares values of the type `xml`.
@test:Config {}
function testAssertNotEqualsXml() {
    xml x1 = xml `<book>The Lost World</book>`;
    xml x2 = xml `Hello, world!`;
    xml x3 = xml `<!--I am a comment-->`;
    xml x4 = xml `<?target data?>`;
    xml x5 = x1 + x2 + x3 + x4;
    xml x6 = xml `<book>The Lost World -2</book>` + xml `Hello, world!` + xml `<!--I am a comment-->` + xml `<?target data?>`;
    test:assertNotEquals(x5, x6, msg = "XML values are equal");
}

//Asserts exact equality.
@test:Config {}
function testAssertExactEqualsObject() {
    Person p1 = new;
    Person p2 = p1;
    test:assertExactEquals(p1, p2, msg = "Objects are not exactly equal");
}

//Asserts exact equality.
@test:Config {}
function testAssertNotExactEqualsObject() {
    Person p1 = new;
    Person p2 = new ();
    test:assertExactNotEquals(p1, p2, msg = "Objects are exactly equal");
}

// Asserts `true`.
@test:Config {}
function testAssertTrue() {
    boolean value = true;
    test:assertTrue(value, msg = "AssertTrue failed");
}

// Asserts `false`.
@test:Config {}
function testAssertFalse() {
    boolean value = false;
    test:assertFalse(value, msg = "AssertFalse failed");
}

// A test-example, which is failing intentionally.
@test:Config {}
function testAssertFail() {
    if (true) {
        return;
    }
    test:assertFail(msg = "AssertFailed");
}

function intAdd(int a, int b) returns (int) {
    return (a + b);
}

function floatAdd(float a, float b) returns (float) {
    return (a + b);
}

function stringConcat(string a, string b) returns (string) {
    return (a + b);
}
