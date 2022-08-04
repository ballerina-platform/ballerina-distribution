import ballerina/test;

@test:Config { }
function testAssertEquals() {
    json a = {name:"John Doe", age:25, address:{city:"Colombo", 
    country:"Sri Lanka"}};
    json b = {name:"John Doe", age:25, address:{city:"Colombo", 
    country:"Sri Lanka"}};
    // Asserts two values for value equality using `assertEquals`.
    test:assertEquals(a, b, msg = "JSON values are not equal");
}

@test:Config { }
function testAssertNotEquals() {
    string s1 = "abc";
    string s2 = "def";
    // Asserts two values for value inequality using `assertNotEquals`.
    test:assertNotEquals(s1, s2, msg = "String values are equal");
}

@test:Config { }
function testAssertTrue() {
    boolean value = true;
    // Asserts if the provided value is `true`.
    test:assertTrue(value, msg = "AssertTrue failed");
}

@test:Config { }
function testAssertFalse() {
    boolean value = false;
    // Asserts if the provided value is `false`.
    test:assertFalse(value, msg = "AssertFalse failed");
}

@test:Config { }
function testAssertFail() {
    boolean flag = true;
    if (flag) {
        return;
    }
    // Intentionally, throws an `AssertionError`.
    test:assertFail(msg = "AssertFailed");
}

class Person {
    public string name = "";
    public int age = 0;
    public Person? parent = ();
    private string email = "default@abc.com";
    string address = "No 20, Palm grove";
}

@test:Config { }
function testAssertExactEquals() {
    Person person1 = new;
    Person person2 = person1;
    // Compares the values for exact equality i.e. whether both refer to the same entity.
    test:assertExactEquals(person1, person2,
        msg = "Objects are not exactly equal");
}

@test:Config { }
function testAssertNotExactEquals() {
    Person person1 = new;
    Person person2 = new;
    // Compares the values for the negation of exact equality.
    test:assertNotExactEquals(person1, person2,
        msg = "Objects are exactly equal");
}
