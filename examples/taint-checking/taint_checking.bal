import ballerina/java.jdbc;
import ballerina/lang.'int;

// The `@untainted` annotation can be used with the parameters of user-defined functions. This allow users to restrict
// passing untrusted (tainted) data into a security sensitive parameter.
function userDefinedSecureOperation(@untainted string secureParameter) {

}

type Student record {
    string firstname;
};

public function main(string... args) {
    jdbc:Client customerDBEP = checkpanic
                    new("jdbc:mysql://localhost:3306/testdb", "root", "root");

    // Sensitive parameters of functions that are built-in to Ballerina are decorated with the `@untainted` annotation.
    // This ensures that tainted data cannot pass into the security sensitive parameter.
    //
    // For example, the taint checking mechanism of Ballerina completely prevents SQL injection vulnerabilities by
    // disallowing tainted data in the SQL query.
    //
    // This line results in a compile error because the query is appended with a user-provided argument.
    var result = customerDBEP->
        query("SELECT firstname FROM student WHERE registration_id = "
                                                            + args[0], ());

    // This line results in a compiler error because a user-provided argument is passed to a sensitive parameter.
    userDefinedSecureOperation(args[0]);

    if (isInteger(args[0])) {
        // After performing necessary validations and/or escaping, we can use type cast expression with @untainted annotation
        // to mark the proceeding value as `trusted` and pass it to a sensitive parameter.
        userDefinedSecureOperation(<@untainted>args[0]);
    } else {
        panic error("Validation error: ID should be an integer");
    }

    checkpanic customerDBEP.close();
}

function isInteger(string input) returns boolean {
    var intVal = 'int:fromString(input);
    return intVal is int;
}
