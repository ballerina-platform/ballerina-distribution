import ballerina/io;
import ballerina/os;

public function main() {
    // Returns the environment variable value associated with "HTTP_PORT".
    string port = os:getEnv("HTTP_PORT");
    io:println("HTTP_PORT: ", port);

    // Returns the current user's name.
    string username = os:getUsername();
    io:println("Username: ", username);

    // Returns the current user's home directory path.
    string userHome = os:getUserHome();
    io:println("Userhome: ", userHome);
}
