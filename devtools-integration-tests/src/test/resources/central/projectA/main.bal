import ballerina/lang.'int as ints;

public function main() {
    int sum = testSum();
}

public function testSum() returns int {
    return ints:sum(10, 25, 35, 40);
}
