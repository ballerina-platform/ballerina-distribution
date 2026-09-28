import ballerina/ai;
import ballerina/file;
import ballerina/io;
import ballerina/uuid;

# A vector entry as it is saved in the file.
type StoredEntry record {|
    # The unique identifier of the entry
    string id;
    # The dense vector of the chunk
    float[] embedding;
    # The chunk content
    string content;
    # The chunk metadata
    ai:Metadata metadata;
|};

// A custom vector store that implements the `ai:VectorStore` type. It keeps the entries in
// a JSON file, so they are available across runs. Replace the file operations with calls to
// your own database or search service to integrate it with a knowledge base.
isolated class JsonFileVectorStore {
    *ai:VectorStore;

    private final string filePath;

    isolated function init(string filePath) {
        self.filePath = filePath;
    }

    // Adds the entries, replacing any existing entry that has the same ID. An ID is generated
    // for entries without one, such as those added by a knowledge base. The `lock`
    // statement prevents concurrent updates from overwriting each other's changes.
    public isolated function add(ai:VectorEntry[] entries) returns ai:Error? {
        readonly & ai:VectorEntry[] newEntries = entries.cloneReadOnly();
        lock {
            map<StoredEntry> stored = check self.readEntries();
            foreach ai:VectorEntry entry in newEntries {
                ai:Embedding embedding = entry.embedding;
                if embedding !is ai:Vector {
                    return error ai:Error("Only dense vectors are supported");
                }
                string id = entry.id ?: uuid:createRandomUuid();
                stored[id] = {
                    id,
                    embedding,
                    content: entry.chunk.content.toString(),
                    metadata: entry.chunk.metadata ?: {}
                };
            }
            check self.writeEntries(stored);
        }
    }

    // Returns the `topK` entries that match the filters, ranked by cosine similarity. A `topK`
    // of `-1` returns all the matching entries.
    public isolated function query(ai:VectorStoreQuery query) returns ai:VectorMatch[]|ai:Error {
        ai:Embedding? queryEmbedding = query?.embedding;
        if queryEmbedding !is ai:Vector? {
            return error ai:Error("Only dense vectors are supported");
        }
        map<StoredEntry> stored = check self.readEntries();
        ai:VectorMatch[] matches = [];
        foreach StoredEntry entry in stored {
            if !check matchesFilters(entry.metadata, query?.filters) {
                continue;
            }
            float score = queryEmbedding is ai:Vector ? cosineSimilarity(queryEmbedding, entry.embedding) : 0.0;
            ai:TextChunk chunk = {content: entry.content, metadata: entry.metadata};
            matches.push({id: entry.id, embedding: entry.embedding, chunk, similarityScore: score});
        }
        ai:VectorMatch[] ranked = from ai:VectorMatch vectorMatch in matches
            order by vectorMatch.similarityScore descending
            select vectorMatch;
        int topK = query.topK;
        return topK < 1 || topK >= ranked.length() ? ranked : ranked.slice(0, topK);
    }

    // Deletes the entries with the given IDs.
    public isolated function delete(string|string[] ids) returns ai:Error? {
        string[] idList = [];
        if ids is string {
            idList.push(ids);
        } else {
            idList.push(...ids);
        }
        readonly & string[] idsToDelete = idList.cloneReadOnly();
        lock {
            map<StoredEntry> stored = check self.readEntries();
            foreach string id in idsToDelete {
                _ = stored.removeIfHasKey(id);
            }
            check self.writeEntries(stored);
        }
    }

    private isolated function readEntries() returns map<StoredEntry>|ai:Error {
        do {
            if !check file:test(self.filePath, file:EXISTS) {
                return {};
            }
            json content = check io:fileReadJson(self.filePath);
            return check content.cloneWithType();
        } on fail error e {
            return error ai:Error("Failed to read the vector store file", e);
        }
    }

    private isolated function writeEntries(map<StoredEntry> entries) returns ai:Error? {
        io:Error? result = io:fileWriteJson(self.filePath, entries.toJson());
        if result is io:Error {
            return error ai:Error("Failed to write the vector store file", result);
        }
    }
}

// Supports filters that compare a metadata field with a value (`==` and `!=`), combined
// with the `AND` or `OR` condition.
isolated function matchesFilters(ai:Metadata metadata, ai:MetadataFilters? filters) returns boolean|ai:Error {
    if filters is () {
        return true;
    }
    foreach ai:MetadataFilters|ai:MetadataFilter filter in filters.filters {
        boolean matched;
        if filter is ai:MetadataFilters {
            matched = check matchesFilters(metadata, filter);
        } else if filter.operator == ai:EQUAL {
            matched = metadata[filter.key] == filter.value;
        } else if filter.operator == ai:NOT_EQUAL {
            matched = metadata[filter.key] != filter.value;
        } else {
            return error ai:Error(string `Unsupported filter operator: ${filter.operator}`);
        }
        if filters.condition == ai:OR && matched {
            return true;
        }
        if filters.condition == ai:AND && !matched {
            return false;
        }
    }
    return filters.condition == ai:AND;
}

isolated function cosineSimilarity(float[] a, float[] b) returns float {
    float dot = 0.0;
    float normA = 0.0;
    float normB = 0.0;
    foreach int i in 0 ..< a.length() {
        dot += a[i] * b[i];
        normA += a[i] * a[i];
        normB += b[i] * b[i];
    }
    return dot / (normA.sqrt() * normB.sqrt());
}

public function main() returns error? {
    ai:VectorStore vectorStore = new JsonFileVectorStore("./vectors.json");

    // Add entries. The embeddings are short, hand-written vectors to keep the example
    // self-contained; in practice, they are produced by an embedding provider.
    check vectorStore.add([
        {
            id: "leave-1",
            embedding: [0.9, 0.1, 0.0],
            chunk: <ai:TextChunk>{content: "Employees get 20 days of paid annual leave.", metadata: {"topic": "leave"}}
        },
        {
            id: "leave-2",
            embedding: [0.7, 0.3, 0.1],
            chunk: <ai:TextChunk>{content: "Unused leave can be carried forward.", metadata: {"topic": "leave"}}
        },
        {
            id: "expense-1",
            embedding: [0.1, 0.2, 0.9],
            chunk: <ai:TextChunk>{content: "Submit expense claims within 30 days.", metadata: {"topic": "expenses"}}
        }
    ]);

    // The store is used through the `ai:VectorStore` type, like any other implementation.
    ai:VectorMatch[] matches = check vectorStore.query({embedding: [0.8, 0.2, 0.0], topK: 2});
    printMatches("Top 2 matches", matches);

    matches = check vectorStore.query({
        filters: {filters: [{key: "topic", operator: ai:EQUAL, value: "expenses"}]}
    });
    printMatches("Entries with the topic 'expenses'", matches);

    check vectorStore.delete("leave-2");

    // A new instance reads the entries that were saved to the file.
    ai:VectorStore reopenedStore = new JsonFileVectorStore("./vectors.json");
    printMatches("Entries after deleting 'leave-2'", check reopenedStore.query({topK: -1}));

    // The custom store can be passed to a knowledge base, which then uses it to store and
    // search the embedded chunks:
    // ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);
}

function printMatches(string title, ai:VectorMatch[] matches) {
    io:println(title, ":");
    foreach ai:VectorMatch vectorMatch in matches {
        io:println(string `- ${vectorMatch.id ?: ""}: ${vectorMatch.chunk.content.toString()} (score: ${
                vectorMatch.similarityScore.round(3)})`);
    }
}
