// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

// Integration tests constants
const string CUSTOM_SUB_MOCK_HEADER = "MockHeader";
const string MOCK_HEADER = "MockHeader";
const string CONTENT_TYPE_JSON = "application/json";
const string CONTENT_TYPE_FORM_URL_ENCODED = "application/x-www-form-urlencoded";
const string HUB_MODE_INTERNAL = "internal";
const string HUB_MODE_REMOTE = "remote";
const string TYPE_JSON = "json";
const string TYPE_XML = "xml";
const string TYPE_STRING = "string";
const string SKIP_SUBSCRIBER_CHECK = "skip_subscriber_check";
const string COMMON_PATH = "/contentTypePublisher/notify/";

const string WEBSUB_TOPIC_ONE = "http://one.websub.topic.com";
const string WEBSUB_TOPIC_TWO = "http://two.websub.topic.com";
const string WEBSUB_TOPIC_THREE = "http://three.websub.topic.com";
const string WEBSUB_TOPIC_FOUR = "http://four.websub.topic.com";
const string WEBSUB_TOPIC_FIVE = "http://one.redir.topic.com";
const string WEBSUB_TOPIC_SIX = "http://two.redir.topic.com";

const string HEADER_ACCEPT = "Accept";
const string HEADER_ACCEPT_LANGUAGE = "Accept-Language";
const string ID_MATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADER_ARRAY = "MatchingAcceptAndAcceptLanguageHeaderArray";
const string ID_MATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS = "MatchingAcceptAndAcceptLanguageHeaders";
const string ID_MATCH_ACCEPT_HEADER = "MatchingAcceptHeader";
const string ID_MATCH_ACCEPT_LANGUAGE_HEADER = "MatchingAcceptLanguageHeader";
const string ID_MISMATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADER_ARRAY = "MisMatchingAcceptAcceptLanguageHeaderArray";
const string ID_MISMATCH_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS = "MisMatchingAcceptAndAcceptLanguageHeaders";
const string ID_MISMATCH_ACCEPT_HEADER = "MisMathingAcceptHeader";
const string ID_MISMATCH_ACCEPT_LANGUAGE_HEADER = "MisMatchingAcceptLanguageHeader";
const string ID_MISSING_ACCEPT_AND_ACCEPT_LANGUAGE_HEADERS = "MissingAcceptAndAcceptLanguageHeaders";
const string LANGUAGE_TYPE_DE = "de-DE";
const string RESPONSE_CODE_ACCEPTED = "202";
const string RESPONSE_CODE_NOT_ACCEPTABLE = "406";
const string RESPONSE_CODE_INTERNAL_SERVER_ERROR = "500";

const string ID_INTENT_VER_REQ_RECEIVED_LOG = "IntentVerificationInvocation";
const string ID_BY_KEY_CREATED_LOG = "DispatchingByKeyCreated";
const string ID_BY_KEY_FEATURE_LOG = "DispatchingByKeyFeatured";
const string ID_BY_HEADER_ISSUE_LOG = "DispatchingByHeaderIssue";
const string ID_BY_HEADER_COMMIT_LOG = "DispatchingByHeaderCommit";
const string ID_BY_HEADER_AND_PAYLOAD_ISSUE_CREATED_LOG = "DispatchingByHeaderAndPayloadKeyCreated";
const string ID_BY_HEADER_AND_PAYLOAD_FEATURE_PULL_LOG = "DispatchingByHeaderAndPayloadKeyFeature";
const string ID_BY_HEADER_AND_PAYLOAD_HEADER_ONLY_LOG = "DispatchingByHeaderAndPayloadKeyForOnlyHeader";
const string ID_BY_HEADER_AND_PAYLOAD_KEY_ONLY_LOG = "DispatchingByHeaderAndPayloadKeyForOnlyKey";
const string ID_REDIRECT_SUBSCRIBER_ONE_LOG = "RedirectSubscriberOneLog";
const string ID_REDIRECT_SUBSCRIBER_TWO_LOG = "RedirectSubscriberTwoLog";
const string ID_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "InternalHubNotificationSubscriberOne";
const string ID_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "InternalHubNotificationSubscriberTwo";
const string ID_EXPLICIT_INTENT_VERIFICATION_LOG = "SubscriptionAndExplicitIntentVerification";
const string ID_HUB_NOTIFICATION_LOG = "InternalAndRemoteHubNotification";
const string ID_HUB_NOTIFICATION_LOG_TWO = "InternalAndRemoteHubNotificationTwo";
const string ID_QUERY_PARAM_LOG = "ContentReceiptForCallbackWithQueryParams";

const string ID_TEXT_SUBSCRIBER_ONE = "ContentTypeSubscriberOneText";
const string ID_XML_SUBSCRIBER_ONE = "ContentTypeSubscriberOneXml";
const string ID_JSON_SUBSCRIBER_ONE = "ContentTypeSubscriberOneJson";
const string ID_TEXT_SUBSCRIBER_TWO = "ContentTypeSubscriberTwoText";
const string ID_XML_SUBSCRIBER_TWO = "ContentTypeSubscriberTwoXml";
const string ID_JSON_SUBSCRIBER_TWO = "ContentTypeSubscriberTwoJson";

const string INTENT_VER_REQ_RECEIVED_LOG = "Intent verification request received";
const string BY_KEY_CREATED_LOG = "Created Notification Received, action: created";
const string BY_KEY_FEATURE_LOG = "Feature Notification Received, domain: feature";
const string BY_HEADER_ISSUE_LOG = "Issue Notification Received, header value: issue action: deleted";
const string BY_HEADER_COMMIT_LOG = "Commit Notification Received, header value: commit action: created";
const string BY_HEADER_AND_PAYLOAD_ISSUE_CREATED_LOG = "Issue Created Notification Received, header value: issue action: created";
const string BY_HEADER_AND_PAYLOAD_FEATURE_PULL_LOG = "Feature Pull Notification Received, header value: pull domain: feature";
const string BY_HEADER_AND_PAYLOAD_HEADER_ONLY_LOG = "HeaderOnly Notification Received, header value: headeronly action: header_only";
const string BY_HEADER_AND_PAYLOAD_KEY_ONLY_LOG = "KeyOnly Notification Received, header value: key_only action: keyonly";
const string REDIRECT_SUBSCRIBER_ONE_LOG = "Successful redirect subscriber one";
const string REDIRECT_SUBSCRIBER_TWO_LOG = "Successful redirect subscriber two";
const string INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "WebSub Notification Received by One: {\"action\":\"publish\", \"mode\":\"internal-hub\"}";
const string INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "WebSub Notification Received by Two: {\"action\":\"publish\", \"mode\":\"internal-hub-two\"}";
const string EXPLICIT_INTENT_VERIFICATION_LOG = "Intent verified explicitly for subscription change request";
const string INTERNAL_HUB_NOTIFICATION_LOG = "WebSub Notification Received: {\"action\":\"publish\", \"mode\":\"internal-hub\"}";
const string REMOTE_HUB_NOTIFICATION_LOG = "WebSub Notification Received: {\"action\":\"publish\", \"mode\":\"remote-hub\"}";
const string INTERNAL_HUB_NOTIFICATION_LOG_TWO = "WebSub Notification Received by Two: {\"action\":\"publish\", \"mode\":\"internal-hub\"}";
const string REMOTE_HUB_NOTIFICATION_LOG_TWO = "WebSub Notification Received by Two: {\"action\":\"publish\", \"mode\":\"remote-hub\"}";
const string QUERY_PARAM_LOG = "Query Params: {\"fooVal\":[\"barVal\"],\"topic\":[\"http://one.websub.topic.com\"]}";

const string XML_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "XML WebSub Notification Received by websubSubscriber: <websub><request>Notification</request><type>Internal</type></websub>";
const string TEXT_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "Text WebSub Notification Received by websubSubscriber: Text update for internal Hub";
const string JSON_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "JSON WebSub Notification Received by websubSubscriber: {\"action\":\"publish\", \"mode\":\"internal-hub\"}";
const string XML_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "XML WebSub Notification Received by websubSubscriberTwo: <websub><request>Notification</request><type>Internal</type></websub>";
const string TEXT_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "Text WebSub Notification Received by websubSubscriberTwo: Text update for internal Hub";
const string JSON_INTERNAL_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "JSON WebSub Notification Received by websubSubscriberTwo: {\"action\":\"publish\", \"mode\":\"internal-hub\"}";
const string XML_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "XML WebSub Notification Received by websubSubscriber: <websub><request>Notification</request><type>Remote</type></websub>";
const string TEXT_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "Text WebSub Notification Received by websubSubscriber: Text update for remote Hub";
const string JSON_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_ONE_LOG = "JSON WebSub Notification Received by websubSubscriber: {\"action\":\"publish\", \"mode\":\"remote-hub\"}";
const string XML_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "XML WebSub Notification Received by websubSubscriberTwo: <websub><request>Notification</request><type>Remote</type></websub>";
const string TEXT_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "Text WebSub Notification Received by websubSubscriberTwo: Text update for remote Hub";
const string JSON_REMOTE_HUB_NOTIFICATION_SUBSCRIBER_TWO_LOG = "JSON WebSub Notification Received by websubSubscriberTwo: {\"action\":\"publish\", \"mode\":\"remote-hub\"}";

const string WEBSUB_PERSISTENCE_TOPIC_ONE = "http://one.persistence.topic.com";
const string WEBSUB_PERSISTENCE_TOPIC_TWO = "http://two.persistence.topic.com";

const string ID_NOTIFICATION_ONE = "NotificationOne";
const string ID_NOTIFICATION_FOUR = "NotificationFour";

const string NOTIFICATION_ONE = "WebSub Notification Received by One: {\"mode\":\"internal\", \"content_type\":\"json\"}";
const string NOTIFICATION_FOUR = "WebSub Notification Received by Four: {\"mode\":\"remote\", \"content_type\":\"xml\"}";
