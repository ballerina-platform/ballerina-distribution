import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// The `Album` record to load records from `albums` table.
type Album record {|
    string id;
    string title;
    string artist;
    float price;
|};

service / on new http:Listener(8080) {
    private final mysql:Client db;

    function init() returns error? {
        // Initiate the mysql client at the start of the service. This will be used
        // throughout the lifetime of the service.
        self.db = check new ("localhost", "root", "Test@123", "MUSIC_STORE", 3306);
    }

    resource function get albums/[string id]() returns Album|http:NotFound|error {
        // Execute simple query to fetch record with requested id.
        Album|sql:Error result = self.db->queryRow(`SELECT * FROM albums WHERE id = ${id}`);

        // Check if record is available or not
        if result is sql:NoRowsError {
            return http:NOT_FOUND;
        } else {
            return result;
        }
    }
}
