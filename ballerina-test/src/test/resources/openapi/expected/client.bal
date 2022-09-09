import ballerina/http;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
public type ClientConfig record {|
    # Configurations related to client authentication
    http:CredentialsConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_1_1;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects? followRedirects = ();
    # Configurations associated with request pooling
    http:PoolConfiguration? poolConfig = ();
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig? circuitBreaker = ();
    # Configurations associated with retrying
    http:RetryConfig? retryConfig = ();
    # Configurations associated with cookies
    http:CookieConfig? cookieConfig = ();
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket? secureSocket = ();
    # Proxy server related options
    http:ProxyConfig? proxy = ();
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# The Stripe REST API. Please see https://stripe.com/docs/api for more details.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector`
    # + serviceUrl - URL of the target service
    # + return - An error if connector initialization failed
    public isolated function init(ClientConfig clientConfig, string serviceUrl) returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Retrieves a PaymentMethod object.
    #
    # + paymentMethod - Payment Method
    # + paymentMethodName - Payment Method
    # + xLimit - limit of the payment
    # + return - Successful response.
    remote isolated function getPaymentMethodsPaymentMethod(string paymentMethod, string paymentMethodName, string xLimit) returns json|error {
        string resourcePath = string `/v1/payment_methods/${getEncodedUri(paymentMethod)}`;
        map<anydata> queryParam = {"payment method name": paymentMethodName};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"X-LIMIT": xLimit};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        json response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Creates a new customer object.
    #
    # + customer - Customer ID
    # + payload - Customer Details
    # + return - Successful response.
    remote isolated function postCustomers(string customer, CustomerCustomerBody payload) returns Customer|error {
        string resourcePath = string `/v1/customer/${getEncodedUri(customer)}`;
        http:Request request = new;
        map<Encoding> requestBodyEncoding = {"address": {style: DEEPOBJECT, explode: true}};
        string encodedRequestBody = createFormURLEncodedRequestBody(payload, requestBodyEncoding);
        request.setPayload(encodedRequestBody, "application/x-www-form-urlencoded");
        Customer response = check self.clientEp->post(resourcePath, request);
        return response;
    }
}
