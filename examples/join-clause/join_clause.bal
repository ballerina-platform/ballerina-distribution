import ballerina/io;

type User record {|
    readonly int id;
    string name;
|};

type Login record {|
    int userId;
    string time;
|};

public function main() {
    table<User> key(id) users = table [
        {id: 1234, name: "Keith"},
        {id: 6789, name: "Anne"}
    ];

    Login[] logins = [
        {userId: 6789, time: "20:10:23"},
        {userId: 1234, time: "10:30:02"},
        {userId: 3987, time: "12:05:00"}
    ];

    string[] loginLog = from var login in logins
                        // The `join` clause iterates any iterable value similarly to the
                        // `from` clause.
                        join var user in users
                        // The `on` condition is used to match the `login` with the `user`
                        // based on the `userId`. The iteration is skipped when the
                        // condition is not satisfied.
                        on login.userId equals user.id


                        select user.name + ":" + login.time;
    io:println(loginLog);
}
