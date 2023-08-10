import ballerina/lang.regexp;
import ballerina/io;

public function main() returns error? {

    string data = "bob@example.net,alice@example.com,charlie@example.org,david@example.xyz,invalid#@example.n%t";

    // Split the comma-separated email list.
    string[] emails = re `,`.split(data);
    io:println(emails);

    // Define a RegExp pattern to match valid email addresses.
    string:RegExp validEmailPattern = re `([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})`;

    // Extract usernames and domains from valid email addresses.
    string[] usernames = [];
    string[] domains = [];
    foreach string email in emails {
        // Check if the email is valid.
        if validEmailPattern.isFullMatch(email) { 
            // Extract the username and domain from the email.
            regexp:Groups? emailGroups = validEmailPattern.findGroups(email);
            if emailGroups is regexp:Groups {
                // 0th element contains the entire match
                usernames.push((<regexp:Span>emailGroups[1]).substring());
                domains.push((<regexp:Span>emailGroups[2]).substring());
            }
        }
    }

    io:println(usernames);
    io:println(domains);
}
