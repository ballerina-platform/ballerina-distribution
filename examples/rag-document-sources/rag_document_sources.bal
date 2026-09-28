import ballerina/ai;
import ballerina/io;
import ballerinax/ai.microsoft.sharepoint;

// Credentials of a Microsoft Entra ID app registration that has the `Sites.Read.All`
// application permission for Microsoft Graph.
configurable string tenantId = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;

// The SharePoint site to load from, in the `{hostname}:/sites/{site-name}` form
// (e.g., `contoso.sharepoint.com:/sites/HR`).
configurable string siteId = ?;

public function main() returns error? {
    // Source 1: local files. The built-in `ai:TextDataLoader` loads `pdf`, `docx`, `markdown`,
    // `html`, and `pptx` files as text documents.
    ai:DataLoader fileLoader = check new ai:TextDataLoader("./leave_policy.pdf", "./employee_handbook.md");
    ai:Document[] fileDocuments = toArray(check fileLoader.load());
    printDocuments("local files", fileDocuments);

    // Source 2: Microsoft SharePoint. The `sharepoint:TextDataLoader` reads files from
    // SharePoint document libraries through the Microsoft Graph API. Here, it loads the
    // PDF and Markdown files in the `Policies` folder of the site's default `Documents`
    // library.
    ai:DataLoader sharePointLoader = check new sharepoint:TextDataLoader(
        {
            auth: {
                tokenUrl: string `https://login.microsoftonline.com/${tenantId}/oauth2/v2.0/token`,
                clientId,
                clientSecret,
                scopes: ["https://graph.microsoft.com/.default"]
            }
        },
        [
            {
                siteId,
                libraries: [{paths: ["/Policies"], includeExtensions: ["pdf", "md"]}]
            }
        ]
    );
    ai:Document[] sharePointDocuments = toArray(check sharePointLoader.load());
    printDocuments("SharePoint", sharePointDocuments);

    // Source 3: content already in memory, such as the body of an HTTP response or a message,
    // can be wrapped as a document directly.
    ai:TextDocument notice = {
        content: "The office is closed on public holidays. Critical support staff may work remotely.",
        metadata: {fileName: "holiday-notice"}
    };
    printDocuments("memory", [notice]);

    // All the documents share the `ai:Document` type, so they can be ingested into a
    // knowledge base together, regardless of where they came from.
    ai:Document[] documents = [...fileDocuments, ...sharePointDocuments, notice];
    io:println("\nTotal documents: ", documents.length());
}

function printDocuments(string origin, ai:Document[] documents) {
    io:println("Loaded from ", origin, ": ", documents.length());
    foreach ai:Document document in documents {
        io:println("- ", document.metadata?.fileName, " (", document.content.toString().length(), " characters)");
    }
}

function toArray(ai:Document|ai:Document[] loaded) returns ai:Document[] {
    if loaded is ai:Document[] {
        return loaded;
    }
    return [loaded];
}
