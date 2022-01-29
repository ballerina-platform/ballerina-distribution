class MyClass {
    int i = 0;
}

public function main() {
    MyClass obj1 = new MyClass();
    MyClass obj2 = new MyClass();
    // The result will be true.
    boolean _ = (obj1 === obj1);
    // The result will be false.
    boolean _ = (obj1 === obj2);
    // The result will be true.
    boolean _ = ([1, 2, 3] == [1, 2, 3]);
    // The result will be false.
    boolean _ = ([1, 2, 3] === [1, 2, 3]);
    // The result will be true.
    boolean _ = (-0.0 == +0.0);
    // The result will be false.
    boolean _ = (-0.0 === +0.0);

}
