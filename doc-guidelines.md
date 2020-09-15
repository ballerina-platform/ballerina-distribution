# Ballerina Doc Guidelines

- [Ballerina Documentation Components](#ballerina-documentation-components)
- [Ballerina By Examples Guidelines](#ballerina-by-examples-guidelines)
- [Ballerina API Documentation Guidelines](#ballerina-api-documentation-guidelines)

## Ballerina Documentation Components

Ballerina language documentation consists of the main components below.

- [Ballerina By Examples](https://ballerina.io/learn/by-example/) - play the role of a quick reference example for language features,libraries, and extensions that are used frequently. It can be thought of as a cut-down version of the User Guide, which tries to introduce the features with quick examples to get an in-depth but practical understanding of a feature.
- [User Guide](https://ballerina.io/learn/) - provides detailed explanations on how a specific feature will work along with some comprehensive examples. It will not necessarily cover all the APIs that are available (that will be covered in API Docs). For example, when considering the I/O APIs, it will not be feasible to cover all the I/O types and operations supported by them.
- [API Docs](https://ballerina.io/learn/api-docs/ballerina/) - include all the possible options and parameter information that are relevant when using an API along with suitable examples. 

Therefore, the combination of the Ballerina By Examples, User Guide, and API Docs represent the complete knowledge required for a Ballerina developer. There will be an overlap of content between these. For example, the User Guide has examples and functionality details to explain language-level features. 

The below is a list of guidelines that must be followed when updating and adding new BBEs and API Docs.

## Ballerina By Examples Guidelines

1. Make the BBEs small, simple, and straight forward. Do not create examples with large lines of code. Otherwise, it will require to scroll through a large example to understand the use case. 

2. Create realistic examples whenever possible. Make sure the example, which explains some feature shows a practical scenario when it can be used. However, sometimes, it may not be possible to create a small-enough practical scenario. It will be required to use your judgement to decide that. 

3. Each new BBE should have its own directory named after it. The directory name should be in all lowercase letters. Use hyphens (`-`) in the directory names (e.g., `hello-world`) and underscores (`_`) in the file names (e.g., `hello_world.bal`).

4. If a new example is added/deleted, update the `index.json` file as well.

>**Info:** Individual BBEs can be configured to disable the playground link generation and to override the default GitHub edit URL by setting the `disablePlayground` and `githubLink` properties accordignly in the `index.json` file. 

For example,

```
{
    	"title": "Ballerina Basics",
    	"column": 0,
    	"category": "Language concepts",
    	"samples": [
        	{
            	"name": "Functions",
            	"url": "functions",
            	"githubLink": "https://github.com/ballerina-platform/ballerina-lang/tree/ballerina-1.2.x/examples/functions/",
            	"disablePlayground": true
        	}
    	]
}
```

5. Each new example should contain at least the following files.

    - `.bal` - sample code to display in the Ballerina website.
    - `.description` - sample description displayed at the top of each example in the Ballerina website. The name should be the same as the name of the directory with hyphens replaced by underscores.
    - `.out` - output of the sample displayed at the bottom inside a black colour box in in the Ballerina website. The output file for a particular `.bal` file should have the same name as the `.bal` file but with the `.out` extension.
    - `_test.bal` - Contains the test to validate the output of the BBE during the build time. 

    For example,

    <img src="/images/bbe-folder-structure.png" alt="BBE folder structure" width="250" height="150">

6. Break the `.description` file content into paragraphs when necessary and use `<br/>` tags to separate them. New lines in the content do not get translated into new lines in the final rendering.

7. As a best practice, use the following format as a common pattern in the `.out` files and customize only when necessary (e.g., when it is needed to add more command line args etc).

    For an example with main:

    ```ballerina
    # To run this sample, navigate to the directory that contains the
    # `.bal` file and issue the `ballerina run` command.
    $ ballerina run <sample_file_name>.bal
    ```

    For an example with a service:

    ```ballerina
    # To start the service, navigate to the directory that contains the
    # `.bal` file and issue the `ballerina run` command.
    $ ballerina run hello_world_service.bal
    ```

8. Service examples demonstrating client-server scenarios have a `.bal` file only for the server and two different output files. That is, one to display the server output (`.server.out` file) and the other (`.client.out` file) to display the cURL command and the output. These two separate output files can be introduced with `.server` and `.client` suffixed to the file names. 

    For example, see the  `hello_world_service.server.out` and `hello_world_service.client.out` files below of the [Hello World Service BBE](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/hello-world-service).

    <img src="/images/service-examples.png" alt="A service example" width="250" height="150">
    
9. Unless it is really required, it is not encouraged to have multiple BAL files in the same sample. In that case, each BAL file can have its own name and the `.out` file should match with the name of the `.bal` file. For example,

<img src="/images/mulitple-bal-files.png" alt="A service example" width="300" height="150">

10. Use language features to make the examples look elegant (and small). For example, string templates, functional iteration, anonymous functions, etc.

11. Use meaningful variable names, function names, etc.

12. Remove unused imports in `.bal` files.

13. Format the Ballerina source using an IDE Plugin. 

14. Do not set (too many or any) optional properties in BBEs (e.g., JDBC connection pooling props). Users will figure it out with code assist or with additional documentation as those will be covered in the User Guide. Also, all the possible options will be covered in the API docs.

15. All keywords and any other word, which needs to be highlighted should be used with backquotes (e.g.,  `xml`).  Do not use a single quote as it will not get highlighted in the Ballerina website. 

    For example, if the keywords are added with backquotes in the BAL file of the BBE as follows,

    ![Code comment in BAL file](/images/bal-file-comment.png)

    will get highlighted in the Ballerina website as follows.

    ![Comment in the BBE](/images/bbe-comment.png)

16. Simplify error handling. Use `check` whenever possible. These examples do not need to show all possible error-handling situations. These possibilities can be shown in the actual error-handling BBEs.

17. As a practice, use `ballerina/io` methods in main examples and `ballerina/log` methods in the examples with services. Do not use both `io:println` and `log:printInfo` in the same sample.

18. Keep the length of the code lines in BBEs to a maximum character count of 80 per line in BAL files. Else, they get wrapped and you get horizontal scroll bars in the code view in the website reducing the readibility.

<img src="/images/max-char-count.png" alt="Max character count" width="650" height="50">

19. Add comments to the code blocks as much as possible with “//” as they are used as a mechanism to describe the code. They will be displayed in the RHS section in the Ballerina website. 

    For example, if a code comment is added in the BAL file of the BBE as follows,

    ![Code comment in BAL file](/images/bal-file-comment.png)

    it will be displayed in the Ballerina website as follows.

    ![Comment in the BBE](/images/bbe-comment.png)

20. Since comments are displayed in the RHS in the website, they should be valid sentences (i.e. start with an upper case letter and end with a full stop etc.)

21. Try to keep the code-level comments short. If there are multiline large comments, the final website view would not be nice in which there will be large gaps between code lines to accommodate the comments in the right side of the code panel. 

22. A comment applies to the subsequent lines in the file until another comment or an empty line is found. Use comments/new lines appropriately to ensure that it applies only to the relevant lines.

23. No restriction is applicable for the maximum character count in comment lines as they will go to RHS side and get wrapped automatically. However, since users can refer to the code in GitHub, it is better if we can have the same char limit as the code lines (i.e., 80) as it increases the readability of the code file.

    For example, comments are significantly longer than the code line in the image below, which is not readable. 

    ![Length of comments](/images/comments-length.png)

24. After any update to a BBE is done or a new BBE is added, please add Anjana Fernando (lafernando) and Praneesha as reviewers.

For information on generating BBEs and testing them locally, see [How To Do the Bio Prod Sync and Doc Generations](https://docs.google.com/document/d/1XrYC4aOnyUg8ge-A_o0dLITJSiJsZw_x428mTUDjpKA/edit?ts=5f52f23b#heading=h.dwgoecewvrjj).

## Running Ballerina By Examples

After writing a Ballerina By Example, you can also run it to test and verify if the output is accurate. Follow the instuctions below to do this.

1. Create a directory with the BBE directories, which you want to test and the `index.json` file (e.g., `/examples`).

2. In the CLI, navigate to the `master` branch of the [ballerina-release](https://github.com/ballerina-platform/ballerina-release) GitHub repo (i.e., `<BALLERINA_RELEASE_REPO_HOME>`).

3. Execute the command below to build the BBEs.

>**Info:** You need to change the properties of the above command accordingly. Also, the `<GEN_PLAYGROUND_LINKS>` property can be set to `false` while testing BBEs locally since with `true` it takes a longer time to run the tool. In the final run, you can set this to `true`.

```
go run ballerinaByExample/tools/generate.go “<SOURCE-OF-THE-BBES>” “<RELEASE-VERSION>” “<OUTPUT-FOLDER>” “<WITH-OR-WITHOUT-FRONT-MATTER>” “<IF-LATEST-VERSION>” “<GEN_PLAYGROUND_LINKS>”
```
For example,

```
go run ballerinaByExample/tools/generate.go "/Documents/examples" "1.2" "by-example" "true" "true" "true"
```

4. Copy the generated `<BALLERINA_RELEASE_REPO_HOME>/by-example` directory.

5. Replace the `<BALLERINA_DEV_WEBSITE_REPO_HOME>/<VERSION>/learn/by-example`directory with the directory you copied.

6. In the CLI, navigate to the `master` branch of the [ballerina-dev-website](https://github.com/ballerina-platform/ballerina-dev-website) GitHub repo (i.e., `<BALLERINA_DEV_WEBSITE_REPO_HOME>`).

7. Execute the `bundle exec jekyll serve` command to build the website locally.

>**Note:** Alternatively, execute the command below if you do not have Jekyll configured locally.

 ```
 docker run -p 4000:4000 --volume="/home/shaf/Documents/source/public/ballerina-dev-website:/srv/jekyll" jekyll/builder:3.8 jekyll serve
 ```

 8. Navigate to the Ballerina By Examples in the dev website built locally and test the BBE updates you did.

## Ballerina API Documentation Guidelines

1. Study the basics and best practices in writing API doc comments. For information, go to [Documenting Ballerina Code](https://ballerina.io/learn/documenting-ballerina-code/).

2. API docs need to explain what the API is about, when, and how it is used. It should not try to explain language features (e.g., error handling, concurrency, etc). The language-level features will have to be covered in the User Guide. 

3. Module-level documentation page needs to introduce the general concept of the API and the main APIs that are used. In the I/O API scenario, this would be the aspects such as the channels concept, how we have different types of channels etc., and their common behavior. 

For example, [Rust’s I/O API documentation](https://doc.rust-lang.org/std/io/index.html) is a good example for this. After the module overview, for each object, record, function, a separate documentation page is added, which will contain their individual details and also their specific examples. For example, see [Struct std::io::Cursor](https://doc.rust-lang.org/std/io/struct.Cursor.html) and [Struct std::io::BufReader](https://doc.rust-lang.org/std/io/struct.BufReader.html). Some APIs that were featured in the main module page will need to again have their own examples in their respective page. Therefore, there will be some overlap of information in that area. 

4. The examples in the API Docs need to be short. Mostly, shorter than BBEs. They usually explain a quick API operation and not a complete, end to end scenario. The same guidelines for BBEs as above should be used for API Docs to keep the examples small and clear. 

5. You should not try to refer to examples in BBEs here with links, but rather have separate examples. This is because the required examples will probably not match the examples in the BBEs in the first place. The API docs will probably have more examples, when it explains each API operation etc. Also, users will not want to click another link and navigate away from the API docs to a separate BBE page. Rather, they will need to see the example in the same place where the API is described. 

6. In scenarios such as error value returns, all possible error types and their scenarios should be mentioned clearly. There should not be statements such as “returns error when something goes wrong”. 

7. As a best practice, do not add a full stop at the end of the first sentence of the parameter and return type descriptions. Instead, add a full stop only at the end of a function description. For example,

```

# Description for the function.
#
# + i - One sentence only
# + s - Sentence one. Sentence two.
# + return - Return description
public function foo(int i, string s) returns boolean {
return true;
}

```

For information on generating API Docs and testing them locally, see [How To Do the Bio Prod Sync and Doc Generations](https://docs.google.com/document/d/1XrYC4aOnyUg8ge-A_o0dLITJSiJsZw_x428mTUDjpKA/edit?ts=5f52f23b#heading=h.dwgoecewvrjj).


