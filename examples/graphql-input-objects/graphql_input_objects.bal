import ballerina/graphql;

// Define the `NewPost` record type to use as an input object.
type NewPost record {|
    string author;
    string content;
|};

// Define the `Post` record type to use as an output object.
type Post record {|
    *NewPost;
    int id;
|};

service /graphql on new graphql:Listener(4000) {

    // Define an in-memory array to store the Posts
    private final Post[] posts = [];

    // This remote method (`addPost`) has an input argument `newPost` of type `NewPost`. This
    // `NewPost` record type will be mapped to an `INPUT_OBJECT` type in the generated GraphQL
    // schema.
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
