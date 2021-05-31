import ballerina/cache;
import ballerina/io;

public function main() returns error? {

    // This creates a new cache with the advanced configuration.
    cache:Cache cache = new ({
        // The maximum size of the cache is 10.
        capacity: 10,
        // The eviction factor is set to 0.2, which means at the
        // time of eviction 10*0.2=2 entries get removed from the cache.
        evictionFactor: 0.2,
        // The default max age of the cache entry is set to 2 seconds.
        defaultMaxAge: 2,
        // The cache cleanup task runs every 3 seconds and clears all
        // the expired entries.
        cleanupInterval: 3
    });

    // Adds the new entries to the cache.
    check cache.put("key1", "value1");
    check cache.put("key2", "value2");
    // Adds a new entry to the cache by overriding the default max age.
    check cache.put("key3", "value3", 3600);

    // Gets the keys of the cache entries.
    string[] keys = cache.keys();
    io:println("The existing keys in the cache: ", keys);

    // Discards the given cache entry.
    _ = check cache.invalidate("key2");

    // Gets the keys of the cache entries.
    io:println("The existing keys in after invalidating a given key: ",
                cache.keys());

    // Discards all the cache entries of the cache.
    _ = check cache.invalidateAll();

    // Gets the keys of the cache entries after all the keys are invalidated.
    io:println("The keys after invalidating all the keys: ", cache.keys());
}
