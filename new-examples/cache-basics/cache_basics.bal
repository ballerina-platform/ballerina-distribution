import ballerina/cache;
import ballerina/io;

public function main() returns error? {
    // This creates a new cache instance with the default configurations.
    cache:Cache cache = new();

    // Adds new entries to the cache.
    check cache.put("key1", "value1");
    check cache.put("key2", "value2");

    // Checks for the cached key availability.
    if (cache.hasKey("key1")) {
        // Fetches the cached value.
        string value = <string> check cache.get("key1");
        io:println("The value of the key1: " + value);
    }
    // Gets the keys of the cache entries.
    string[] keys = cache.keys();
    io:println("The existing keys in the cache: " + keys.toString());

    // Gets the size of the cache.
    int size = cache.size();
    io:println("The cache size: ", size);
}
