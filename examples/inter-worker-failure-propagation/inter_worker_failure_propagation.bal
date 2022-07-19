import ballerina/io;

int counter = 0;

function demo() returns int|error {
    worker A returns error? {
        // Workers may need to call functions that can return an `error`. 
        // Pairing up of sends and receives guarantees that each send will be received, and vice-versa,
        // provided neither sending nor receiving worker has failed.
        error? res = foo();
        if res is error {
            return res;
        }
        42 -> function;
    }

    // Send to or receive from failed worker will propagate the failure.
    int x = check <- A;

    return x;
}

function foo() returns error? {
    if counter == 1 {
        return error("maximum count exceeded");
    }

    counter += 1;
}

public function main() returns error? {
    int a = check demo();
    io:println(a);

    int b = check demo();
    io:println(b);
}
