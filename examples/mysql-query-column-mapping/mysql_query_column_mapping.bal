import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// The `Album` record to load records from `albums` table.
type Artist record {|
    @sql:Column {name: "artist_id"}
    int artistId;
    @sql:Column {name: "last_name"}
    string lastName;
    @sql:Column {name: "first_name"}
    string firstName;
|};

service / on new http:Listener(8080) {
    private final mysql:Client db;

    function init() returns error? {
        // Initiate the mysql client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.db = check new ("localhost", "root", "Test@123", "MUSIC_STORE", 3306);
    }

    resource function get artists() returns Artist[]|error {
        // Execute simple query to retrieve all records from the `artist` table.
        stream<Artist, sql:Error?> artistStream = self.db->query(`SELECT * FROM artists;`);

        // Process the stream and convert results to Artist[] or return error.
        return from Artist artist in artistStream
            select artist;
    }
}
