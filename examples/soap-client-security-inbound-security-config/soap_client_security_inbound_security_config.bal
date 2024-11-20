import ballerina/soap.soap12;
import ballerina/crypto;

public function main() returns error? {
    crypto:KeyStore keyStore = {
        path: "/path/to/keyStore.p12",
        password: "keyStorePassword"
    };
    crypto:KeyStore decryptionKeyStore = {
        path: "/path/to/keyStore.p12",
        password: "keyStorePassword"
    };

    soap12:Client soapClient = check new ("http://soap-endpoint.com?wsdl",
        {
            inboundSecurity: {
                signatureKeystore: keyStore,
                decryptKeystore: decryptionKeyStore
            }
        }
    );
    xml body = xml `<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope">
                        <soap:Body></soap:Body>
                    </soap:Envelope>`;

    check soapClient->sendOnly(body);
}
