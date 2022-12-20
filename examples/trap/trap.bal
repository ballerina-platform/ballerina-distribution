import ballerina/io;

// `n` must not be `0`.
function divide(int m, int n) returns int {

   if n == 0 {
       // Panic if `n` is `0`.
       terminate("division by 0");
   }

   return m / n;
}

// this function always panics
function terminate(string msg) returns never {
   panic error(msg);
}

public function main() {

   // Even though `divide(1, 0)` panics, due to the trap expression, the program will not terminate here.
   int|error result = trap divide(1, 0);

    io:println(result);

   // `trap` can be used when the expected type is `never`
   error x = trap terminate("panic");

   io:println(x);
}
