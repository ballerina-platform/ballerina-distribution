import ballerina/crypto;
import ballerina/soap.soap12;

public function main() returns error? {
    crypto:KeyStore keyStore = {
        path: "/path/to/keyStore.p12",
        password: "keyStorePassword"
    };
    crypto:KeyStore decryptionKeyStore = {
        path: "/path/to/decryptionKeyStore.p12",
        password: "keyStorePassword"
    };

    soap12:Client soapClient = check new ("http://soap-endpoint.com?wsdl",
        {
            outboundSecurity: {
                signatureConfig: {
                    keystore: keyStore,
                    privateKeyAlias: "private-key-alias",
                    privateKeyPassword: "private-key-password"
                },
                encryptionConfig: {
                    keystore: decryptionKeyStore,
                    publicKeyAlias: "public-key-alias"
                }
            }
        }
    );
    xml body = xml `<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope">
                        <soap:Body></soap:Body>
                    </soap:Envelope>`;
    check soapClient->sendOnly(body);
}
