# Ballerina Doc Guidelines

Ballerina language documentation consists of the main componnets below.

- [Ballerina By Examples](https://ballerina.io/learn/by-example/) - play the role of a quick reference example for language features,libraries, and extensions that are used frequently. It can be thought of as a cut-down version of the User Guide, which tries to introduce the features with quick examples to get an in-depth but practical understanding of a feature.
- [User Guide](https://ballerina.io/learn/) - provides detailed explanations on how a specific feature will work along with some comprehensive examples. It will not necessarily cover all the APIs that are available (that will be covered in API Docs). For example, when considering the I/O APIs, it will not be feasible to cover all the I/O types and operations supported by them.
- [API Docs](https://ballerina.io/learn/api-docs/ballerina/) - include all the possible options and parameter information that are relevant when using an API along with suitable examples. 

Therefore, the combination of the Ballerina By Examples, User Guide, and API Docs represent the complete knowledge required for a Ballerina developer. There will be an overlap of content between these. For example, the User Guide has examples and functionality details to explain language-level features. 

The below is a list of guidelines that must be followed when updating and adding new BBEs and API Docs.

- [Ballerina By Examples Guidelines](#ballerina-by-examples-guidelines)
- [Ballerina API Documentation Guidelines](#ballerina-api-documentation-guidelines)

## Ballerina By Examples Guidelines

1. Make the BBEs small, simple, and straight forward. Do not create examples with large lines of code; a user will not like to scroll through a large example to understand what is happening. 

2. Create realistic examples whenever possible. Make sure the example, which explains some feature shows a practical scenario when it can be used. However, sometimes, it may not be possible to create a small enough practical scenario. Then, we have to use our judgement to decide that. 

3. Use meaningful variable names, function names, etc.

4. Don't set (too many or any) optional properties in BBEs (e.g., JDBC connection pooling props). Users will figure it out with code assist or with additional documentation as those will be covered in the User Guide. Also, all the possible options will be covered in the API docs.

5. Simplify error handling. Use `check` whenever possible. These examples do not need to show all possible error-handling situations. These possibilities can be shown in the actual error-handling BBEs.

6. Use language features to make the examples look elegant (and small). For example, string templates, functional iteration, anonymous functions, etc.

7. Keep the length of the code lines in BBEs to maximum 80 columns. Else, you get horizontal scroll bars in the code view in the website.

8.  No restriction is applicable for the max chars in comment lines as they will go to RHS side and get wrapped automatically. However, since users can refer to the code in GitHub, it is better if we can have the same char limit as the code line (i.e., 80) as it increases the readability of the code file.

9. Break the `.description` file content into paragraphs when necessary, and use “<br/>” tags to separate them. New lines in the content do not get translated into new lines in the final rendering.

10. Try to keep the code level comments short. If there are multiline large comments, the final website view would not be nice in which there will be large gaps between code lines to accommodate the comments in the right side of the code panel. 

11. A comment applies to the subsequent lines in the file until another comment or an empty line is found. Use comments/new lines appropriately to ensure that it applies only to the relevant lines.

12. Since comments are displayed in the RHS in the website, they should be valid sentences (i.e. start with an upper case letter and end with a full stop etc.)

13. All keywords and any other word, which needs to be highlighted should be used with backquotes (e.g.,  `xml`).  Don’t use a single quote as it will not get highlighted in the Ballerina website. 

    For example, if the code comment is added as follows in the BAL file of the BBE,

    ![Code comment in BAL file](/images/bal-file-comment.png)

    it will be rendered as follows in the Ballerina website.

    ![Comment in the BBE](/images/bbe-comment.png)

14. Format the Ballerina source using an IDE Plugin. 

15. If a new example is added/deleted, update the `index.json` file as well.

16. After any update to a BBE is done or a new BBE is added, please add Anjana Fernando (lafernando) and Praneesha as reviewers.

- For a list of updates done for the existing BBEs, go to [BBE Review - Swan Lake](https://docs.google.com/spreadsheets/d/1H3m2UF62_LG8dV4U_YuXadyAhhRtwLYx7Gew5M64UuU/edit#gid=0).

- For information on generating BBEs and testing them locally, see [How To Do the Bio Prod Sync and Doc Generations](https://docs.google.com/document/d/1XrYC4aOnyUg8ge-A_o0dLITJSiJsZw_x428mTUDjpKA/edit?ts=5f52f23b#heading=h.dwgoecewvrjj).

## Ballerina API Documentation Guidelines

1. Study the basics and best practices in writing API doc comments. For information, go to [Documenting Ballerina Code](https://ballerina.io/learn/documenting-ballerina-code/).

2. API docs need to explain what the API is about, when, and how it is used. It should not try to explain language features (e.g., error handling, concurrency, etc). The language-level features will have to be covered in the User Guide. 

3. Module-level documentation page needs to introduce the general concept of the API and the main APIs that are used. In the I/O API scenario, this would be the aspects such as the channels concept, how we have different types of channels etc., and their common behavior. 

For example, [Rust’s I/O API documentation](https://doc.rust-lang.org/std/io/index.html) is a good example for this. After the module overview, for each object, record, function, a separate documentation page is added, which will contain their individual details and also their specific examples. For example, see [Struct std::io::Cursor](https://doc.rust-lang.org/std/io/struct.Cursor.html) and [Struct std::io::BufReader](https://doc.rust-lang.org/std/io/struct.BufReader.html). Some APIs that were featured in the main module page will need to again have their own examples in their respective page. Therefore, there will be some overlap of information in that area. 

4. The examples in the API Docs need to be short. Mostly, shorter than BBEs. They usually explain a quick API operation and not a complete, end to end scenario. The same guidelines for BBEs should be used for API Docs to keep the examples small and clear. 

5. You should not try to refer to examples in BBEs here with links, but rather have separate examples. This is because the required examples will probably not match the examples in the BBEs in the first place. The API docs will probably have more examples, when it explains each API operation etc. Also, users will not want to click another link and navigate away from the API docs to a separate BBE page. Rather, they will need to see the example in the same place where the API is described. 

6. In scenarios such as error value returns, all possible error types and their scenarios should be mentioned clearly. There should not be statements such as “returns error when something goes wrong”. 

7. As a best practice, do not add a full stop at the end of the first sentence of the parameter and return type descriptions. Instead, add a fullstop only at the end of a function description. For Example,

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


