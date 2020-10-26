import ballerina/ftp;
import ballerina/test;

@test:Config {}
function testFtp() {
    ftp:ClientEndpointConfig config = {
            protocol: ftp:FTP,
            host: "127.0.0.1",
            port: 21212,
            secureSocket: {basicAuth: {username: "wso2", password: "wso2123"}}
    };
    test:assertEquals(config.host, "127.0.0.1");
}
