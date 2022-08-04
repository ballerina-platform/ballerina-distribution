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

>**Note:** The first letter of every word in the title of the BBE should be uppercase. Never capitalize prepositions and conjunctions of four or fewer letters. Words with five or more letters, regardless of whether the word is a conjunction or preposition, must be capitalized.

4. If a new example is added/deleted, update the `index.json` file as well.

    >**Info:** Individual BBEs can be configured to disable the playground link generation and to override the default GitHub edit URL by setting the `disablePlayground` and `githubLink` properties accordignly in the `index.json` file. 

    For example,

    ```json
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
    - `.metatags` - Contains the meta description and keywords to build SEO in the webpage. The description should be 50-160 characters long, and there should be 3-5 keywords that are comma-separated.
    
        For example,
        
        [Hello World BBE .metatags file](https://github.com/ballerina-platform/ballerina-distribution/blob/master/examples/hello-world/hello_world.metatags)  
        description: BBE on how to print “Hello, World!” using a main function in Ballerina. A public function named main is considered as an entry point to a Ballerina program.  
        keywords: ballerina, ballerina by example, bbe, hello world main function
        

6. Break the `.description` file content into paragraphs when necessary and use `<br/>` tags to separate them. New lines in the content do not get translated into new lines in the final rendering.

7. As a best practice, use the following format as a common pattern in the `.out` files and customize only when necessary (e.g., when it is needed to add more command line args etc).

    For an example with main:

    ```bash
    # To run this sample, navigate to the directory that contains the
    # `.bal` file and issue the `bal run` command.
    bal run <sample_file_name>.bal
    ```

    For an example with a service:

    ```bash
    # To start the service, navigate to the directory that contains the
    # `.bal` file and issue the `bal run` command.
    bal run hello_world_service.bal
    ```

8. Service examples demonstrating client-server scenarios have a `.bal` file only for the server and two different output files. That is, one to display the server output (`.server.out` file) and the other (`.client.out` file) to display the cURL command and the output. These two separate output files can be introduced with `.server` and `.client` suffixed to the file names. 

    For example, see the  `hello_world_service.server.out` and `hello_world_service.client.out` files below of the [Hello World Service BBE](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/hello-world-service).

    <img src="/images/service-examples.png" alt="A service example" width="250" height="150">

    >**Note:** The `server.out` file will be displayed first on the website.
    
9. Unless it is really required, it is not encouraged to have multiple BAL files in the same sample. In that case, each BAL file can have its own name and the `.out` file should match with the name of the `.bal` file. For example,

    <img src="/images/mulitple-bal-files.png" alt="A service example" width="350" height="150">

    >**Note:** The `publisher.bal` file and its `publisher.out` file will be displayed first on the website (before the subscriber files).

10. Currently, you can add `.proto`,`.conf`, and `.toml` files also to be displayed on the website. For example, see the [GRPC Bidirectional Streaming BBE](https://ballerina.io/learn/by-example/grpc-bidirectional-streaming.html).

>**Note:** The `.proto` files will be displayed first on the website. The `.conf` and `.toml` files will be displayed just before the last `.out` file.

11. Use language features to make the examples look elegant (and small). For example, string templates, functional iteration, anonymous functions, etc.

12. Use meaningful variable names, function names, etc.

13. Remove unused imports in `.bal` files.

14. Format the Ballerina source using an IDE Plugin. 

15. Do not set (too many or any) optional properties in BBEs (e.g., JDBC connection pooling props). Users will figure it out with code assist or with additional documentation as those will be covered in the User Guide. Also, all the possible options will be covered in the API docs.

16. All keywords and any other word, which needs to be highlighted should be used with backquotes (e.g.,  `xml`).  Do not use a single quote as it will not get highlighted in the Ballerina website. 

    For example, if the keywords are added with backquotes in the BAL file of the BBE as follows,

    ![Code comment in BAL file](/images/bal-file-comment.png)

    will get highlighted in the Ballerina website as follows.

    ![Comment in the BBE](/images/bbe-comment.png)

17. Simplify error handling. Use `check` whenever possible. These examples do not need to show all possible error-handling situations. These possibilities can be shown in the actual error-handling BBEs.

18. As a practice, use `ballerina/io` methods in main examples and `ballerina/log` methods in the examples with services. Do not use both `io:println` and `log:printInfo` in the same sample.

19. Keep the length of the code lines in BBEs to a maximum character count of 80 per line in BAL files. Else, they get wrapped and you get horizontal scroll bars in the code view in the website reducing the readibility.

    <img src="/images/max-char-count.png" alt="Max character count" width="520" height="70">

20. Add comments to the code blocks as much as possible with “//” as they are used as a mechanism to describe the code. They will be displayed in the RHS section in the Ballerina website. 

    For example, if a code comment is added in the BAL file of the BBE as follows,

    ![Code comment in BAL file](/images/bal-file-comment.png)

    it will be displayed in the Ballerina website as follows.

    ![Comment in the BBE](/images/bbe-comment.png)

21. Since comments are displayed in the RHS in the website, they should be valid sentences (i.e. start with an upper case letter and end with a full stop etc.)

22. Try to keep the code-level comments short. If there are multiline large comments, the final website view would not be nice in which there will be large gaps between code lines to accommodate the comments in the right side of the code panel. 

23. A comment applies to the subsequent lines in the file until another comment or an empty line is found. Use comments/new lines appropriately to ensure that it applies only to the relevant lines.

24. No restriction is applicable for the maximum character count in comment lines as they will go to RHS side and get wrapped automatically. However, since users can refer to the code in GitHub, it is better if we can have the same char limit as the code lines (i.e., 80) as it increases the readability of the code file.

    For example, comments are significantly longer than the code line in the image below, which is not readable. 

    ![Length of comments](/images/comments-length.png)

25. After any update to a BBE is done or a new BBE is added, please add Anjana Fernando (lafernando) and Praneesha as reviewers.

## Running Ballerina By Examples

After writing a Ballerina By Example, you can also run it to test and verify if the output is accurate. Follow the instuctions below to do this.

1. Create a directory with the BBE directories, which you want to test and the `index.json` file (e.g., `/examples`).

2. In the CLI, navigate to the `master` branch of the [ballerina-release](https://github.com/ballerina-platform/ballerina-release) GitHub repo (i.e., `<BALLERINA_RELEASE_REPO_HOME>`).

3. Execute the command below to build the BBEs.

    >**Info:** You need to change the properties of the above command accordingly. Also, the `<GEN_PLAYGROUND_LINKS>` property can be set to `false` while testing BBEs locally since with `true` it takes a longer time to run the tool. In the final run, you can set this to `true`.

    ```bash
    go run ballerinaByExample/tools/generate.go “<SOURCE-OF-THE-BBES>” “<RELEASE-VERSION>” “<OUTPUT-FOLDER>” “<WITH-OR-WITHOUT-FRONT-MATTER>” “<IF-LATEST-VERSION>” “<GEN_PLAYGROUND_LINKS>”
    ```
    For example,

    ```bash
    go run ballerinaByExample/tools/generate.go "/Documents/examples" "1.2" "by-example" "true" "true" "true"
    ```

4. Copy the generated `<BALLERINA_RELEASE_REPO_HOME>/by-example` directory.

5. Replace the `<BALLERINA_DEV_WEBSITE_REPO_HOME>/<VERSION>/learn/by-example`directory with the directory you copied.

6. In the CLI, navigate to the `master` branch of the [ballerina-dev-website](https://github.com/ballerina-platform/ballerina-dev-website) GitHub repo (i.e., `<BALLERINA_DEV_WEBSITE_REPO_HOME>`).

7. Execute the `bundle exec jekyll serve` command to build the website locally.

    >**Note:** Alternatively, execute the command below if you do not have Jekyll configured locally.

    ```bash
    docker run -p 4000:4000 --volume="/home/shaf/Documents/source/public/ballerina-dev-website:/srv/jekyll" jekyll/builder:3.8 jekyll serve
    ```

 8. Navigate to the Ballerina By Examples in the dev website built locally and test the BBE updates you did.

## Ballerina API Documentation Guidelines

For Ballerina API Documentation Guidelines, see the [Standard Library API Documentation Guide](https://github.com/ballerina-platform/ballerina-standard-library/blob/main/docs/api-documentation-guide.md).
