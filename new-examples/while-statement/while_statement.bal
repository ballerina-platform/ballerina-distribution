import ballerina/io;

public function main() {
    LinkedList link1 = {value: "link1", next: ()};
    LinkedList link2 = {value: "link2", next: link1};
    io:println(len(link2));
}

type LinkedList record {
    string value;
    LinkedList? next;
};

function len(LinkedList ll) returns int {
    int n = 0;
    LinkedList? v = ll;
    while v != () {
        n += 1;
        if v is LinkedList {
            v = v.next;
        }
    }
    return n;
}
