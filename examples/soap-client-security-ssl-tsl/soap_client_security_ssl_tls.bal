import ballerina/soap.soap12;

public function main() returns error? {
    soap12:Client soapClient = check new ("https://soap-endpoint.com?wsdl",
        {
            httpConfig: {
                secureSocket: {
                    cert: "../resource/path/to/public.crt"
                }
            }
        }
    );

    xml body = xml `<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope">
                        <soap:Body></soap:Body>
                    </soap:Envelope>`;
    check soapClient->sendOnly(body);
}
