import ballerina/graphql;

service /graphql on new graphql:Listener(4000) {

    // Define an in-memory array to store the Posts
    private final Post[] posts = [];

    // The input parameters of a resolver function become input arguments of the corresponding
    // GraphQL field. In this GraphQL service, the `addPost` remote method has an input argument
    // `newPost` of type `NewPost`. This `NewPost` record type will be mapped to an `INPUT_OBJECT`
    // type in the generated GraphQL schema.
    remote function addPost(NewPost newPost) returns Post {
        int id = self.posts.length();
        Post post = {id: id, ...newPost};
        self.posts.push(post);
        return post;
    }

    // Query resolver to retrive all the posts
    resource function get posts() returns Post[] {
        return self.posts;
    }
}

// Define the `NewPost` record type to use as an input object.
public type NewPost record {|
    string author;
    string content;
|};

// Define the `Post` record type to use as an output object.
public type Post record {|
    *NewPost;
    int id;
|};
