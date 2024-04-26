import ballerina/crypto;
import ballerina/soap;
import ballerina/soap.soap12;

public function main() returns error? {
    crypto:PrivateKey verificationKey = check crypto:decodeRsaPrivateKeyFromKeyFile(
        "../resource/path/to/private.key",
        "password"
    );
    crypto:PublicKey decryptionKey = check crypto:decodeRsaPublicKeyFromCertFile(
        "../resource/path/to/public.crt"
    );

    soap12:Client soapClient = check new ("http://soap-endpoint.com?wsdl",
        {
            outboundSecurity: {
                verificationKey: verificationKey,
                signatureAlgorithm: soap:RSA_SHA256,
                decryptionKey: decryptionKey,
                decryptionAlgorithm: soap:RSA_ECB
            }
        }
    );

    xml body = xml `<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope">
                        <soap:Body></soap:Body>
                    </soap:Envelope>`;
    check soapClient->sendOnly(body);
}
