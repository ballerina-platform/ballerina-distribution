// The Ballerina WebSub Subscriber service, which could be used as a WebHook Listener for GitHub.
import ballerina/websub;
import ballerina/io;

public type User record {|
    string login;
    int id;
    string node_id?;
    string avatar_url;
    string gravatar_id;
    string url;
    string html_url;
    string followers_url;
    string following_url;
    string gists_url;
    string starred_url;
    string subscriptions_url;
    string organizations_url;
    string repos_url;
    string events_url;
    string received_events_url;
    string 'type; //"type" in payload
    boolean site_admin;
    string name?;
    string email?;
|};

public type Repository record {|
    int id;
    string node_id;
    string name;
    string full_name;
    User owner;
    boolean 'private; //"private" in payload
    string html_url;
    string? description;
    boolean 'fork;
    string url;
    string forks_url;
    string keys_url;
    string collaborators_url;
    string teams_url;
    string hooks_url;
    string issue_events_url;
    string events_url;
    string assignees_url;
    string branches_url;
    string tags_url;
    string blobs_url;
    string git_tags_url;
    string git_refs_url;
    string trees_url;
    string statuses_url;
    string languages_url;
    string stargazers_url;
    string contributors_url;
    string subscribers_url;
    string subscription_url;
    string commits_url;
    string git_commits_url;
    string comments_url;
    string issue_comment_url;
    string contents_url;
    string compare_url;
    string merges_url;
    string archive_url;
    string downloads_url;
    string issues_url;
    string pulls_url;
    string milestones_url;
    string notifications_url;
    string labels_url;
    string releases_url;
    string|int created_at;
    string updated_at;
    string|int pushed_at;
    string git_url;
    string ssh_url;
    string clone_url;
    string svn_url;
    string? homepage;
    int size;
    int stargazers_count;
    int watchers_count;
    string? language;
    boolean has_issues;
    boolean has_downloads;
    boolean has_wiki;
    boolean has_pages;
    int forks_count;
    string? mirror_url;
    string deployments_url?;
    int open_issues_count;
    string? license;
    int forks;
    int open_issues;
    int watchers;
    string default_branch;
    boolean archived?;
    boolean disabled?;
    boolean has_projects?;
    boolean allow_squash_merge?;
    boolean allow_merge_commit?;
    boolean allow_rebase_merge?;
    boolean delete_branch_on_merge?;
    int stargazers?;
    string master_branch?;
|};

public type PingEvent record {|
    string zen;
    int hook_id;
    json hook;
    Repository repository;
    User sender;
|};

public type PushEvent record {|
    string ref;
    string before;
    string after;
    boolean created;
    boolean deleted;
    boolean forced;
    string? base_ref;
    string compare;
    json[] commits;
    json? head_commit;
    Repository repository;
    json pusher;
    User sender;
|};

// Current supported GitHub WebHook event types.
public type GitHubEvent PingEvent|PushEvent;

// The endpoint to which the webhook service is inbound.
listener websub:Listener websubEP = new (9090);

// Annotation-based configurations specifying the subscription parameters.
@websub:SubscriberServiceConfig {
    target: ["https://api.github.com/hub", "https://github.com/<YOUR_ORGANIZATION>/<YOUR_REPOSITORY>/events/push.json"],
    secret: "<YOUR_SECRET_KEY>",
    callback: "<YOUR_CALLBACK_URL>",
    httpConfig: {
        auth: {
            token: "<YOUR_AUTH_TOKEN>"
        }
    }
}
service /subscriber on websubEP {
    // Defines the remote function that accepts the event notification request for the WebHook.
    remote function onEventNotification(websub:ContentDistributionMessage event) {
        var payload = event.content.cloneWithType(GitHubEvent);
        if(payload is PingEvent) {
            io:println(string`Ping Event received for webhook [${payload.hook_id}]. Event sender [${payload.sender.id}]`);
        } else if (payload is PushEvent) {
            io:println(string`Push Event received for repository [${payload.repository.name}]. Last updated at ${payload.repository.updated_at}`);
        } else {
            io:println("Unrecognized event received, hence igonoring");
        }
    }
}
