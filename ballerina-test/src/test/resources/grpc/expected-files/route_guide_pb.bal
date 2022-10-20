import ballerina/grpc;
import ballerina/protobuf;

const string ROUTE_GUIDE_DESC = "0A11726F7574655F67756964652E70726F746F120A726F757465677569646522410A05506F696E74121A0A086C6174697475646518012001280552086C61746974756465121C0A096C6F6E67697475646518022001280552096C6F6E67697475646522510A0952656374616E676C6512210A026C6F18012001280B32112E726F75746567756964652E506F696E7452026C6F12210A02686918022001280B32112E726F75746567756964652E506F696E7452026869224C0A074665617475726512120A046E616D6518012001280952046E616D65122D0A086C6F636174696F6E18022001280B32112E726F75746567756964652E506F696E7452086C6F636174696F6E22540A09526F7574654E6F7465122D0A086C6F636174696F6E18012001280B32112E726F75746567756964652E506F696E7452086C6F636174696F6E12180A076D65737361676518022001280952076D6573736167652293010A0C526F75746553756D6D617279121F0A0B706F696E745F636F756E74180120012805520A706F696E74436F756E7412230A0D666561747572655F636F756E74180220012805520C66656174757265436F756E74121A0A0864697374616E6365180320012805520864697374616E636512210A0C656C61707365645F74696D65180420012805520B656C617073656454696D653285020A0A526F757465477569646512360A0A4765744665617475726512112E726F75746567756964652E506F696E741A132E726F75746567756964652E466561747572652200123E0A0C4C697374466561747572657312152E726F75746567756964652E52656374616E676C651A132E726F75746567756964652E4665617475726522003001123E0A0B5265636F7264526F75746512112E726F75746567756964652E506F696E741A182E726F75746567756964652E526F75746553756D6D61727922002801123F0A09526F7574654368617412152E726F75746567756964652E526F7574654E6F74651A152E726F75746567756964652E526F7574654E6F746522002801300142680A1B696F2E677270632E6578616D706C65732E726F7574656775696465420F526F757465477569646550726F746F50015A36676F6F676C652E676F6C616E672E6F72672F677270632F6578616D706C65732F726F7574655F67756964652F726F7574656775696465620670726F746F33";

public isolated client class RouteGuideClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROUTE_GUIDE_DESC);
    }

    isolated remote function GetFeature(Point|ContextPoint req) returns Feature|grpc:Error {
        map<string|string[]> headers = {};
        Point message;
        if req is ContextPoint {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("routeguide.RouteGuide/GetFeature", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Feature>result;
    }

    isolated remote function GetFeatureContext(Point|ContextPoint req) returns ContextFeature|grpc:Error {
        map<string|string[]> headers = {};
        Point message;
        if req is ContextPoint {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("routeguide.RouteGuide/GetFeature", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Feature>result, headers: respHeaders};
    }

    isolated remote function RecordRoute() returns RecordRouteStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("routeguide.RouteGuide/RecordRoute");
        return new RecordRouteStreamingClient(sClient);
    }

    isolated remote function ListFeatures(Rectangle|ContextRectangle req) returns stream<Feature, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        Rectangle message;
        if req is ContextRectangle {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("routeguide.RouteGuide/ListFeatures", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        FeatureStream outputStream = new FeatureStream(result);
        return new stream<Feature, grpc:Error?>(outputStream);
    }

    isolated remote function ListFeaturesContext(Rectangle|ContextRectangle req) returns ContextFeatureStream|grpc:Error {
        map<string|string[]> headers = {};
        Rectangle message;
        if req is ContextRectangle {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("routeguide.RouteGuide/ListFeatures", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        FeatureStream outputStream = new FeatureStream(result);
        return {content: new stream<Feature, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function RouteChat() returns RouteChatStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("routeguide.RouteGuide/RouteChat");
        return new RouteChatStreamingClient(sClient);
    }
}

public client class RecordRouteStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendPoint(Point message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextPoint(ContextPoint message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveRouteSummary() returns RouteSummary|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <RouteSummary>payload;
        }
    }

    isolated remote function receiveContextRouteSummary() returns ContextRouteSummary|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <RouteSummary>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class FeatureStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Feature value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Feature value;|} nextRecord = {value: <Feature>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class RouteChatStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendRouteNote(RouteNote message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextRouteNote(ContextRouteNote message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveRouteNote() returns RouteNote|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <RouteNote>payload;
        }
    }

    isolated remote function receiveContextRouteNote() returns ContextRouteNote|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <RouteNote>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class RouteGuideRouteSummaryCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRouteSummary(RouteSummary response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRouteSummary(ContextRouteSummary response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class RouteGuideRouteNoteCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRouteNote(RouteNote response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRouteNote(ContextRouteNote response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class RouteGuideFeatureCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendFeature(Feature response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextFeature(ContextFeature response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextRouteNoteStream record {|
    stream<RouteNote, error?> content;
    map<string|string[]> headers;
|};

public type ContextPointStream record {|
    stream<Point, error?> content;
    map<string|string[]> headers;
|};

public type ContextFeatureStream record {|
    stream<Feature, error?> content;
    map<string|string[]> headers;
|};

public type ContextRouteSummary record {|
    RouteSummary content;
    map<string|string[]> headers;
|};

public type ContextRouteNote record {|
    RouteNote content;
    map<string|string[]> headers;
|};

public type ContextRectangle record {|
    Rectangle content;
    map<string|string[]> headers;
|};

public type ContextPoint record {|
    Point content;
    map<string|string[]> headers;
|};

public type ContextFeature record {|
    Feature content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: ROUTE_GUIDE_DESC}
public type RouteSummary record {|
    int point_count = 0;
    int feature_count = 0;
    int distance = 0;
    int elapsed_time = 0;
|};

@protobuf:Descriptor {value: ROUTE_GUIDE_DESC}
public type RouteNote record {|
    Point location = {};
    string message = "";
|};

@protobuf:Descriptor {value: ROUTE_GUIDE_DESC}
public type Rectangle record {|
    Point lo = {};
    Point hi = {};
|};

@protobuf:Descriptor {value: ROUTE_GUIDE_DESC}
public type Point record {|
    int latitude = 0;
    int longitude = 0;
|};

@protobuf:Descriptor {value: ROUTE_GUIDE_DESC}
public type Feature record {|
    string name = "";
    Point location = {};
|};

