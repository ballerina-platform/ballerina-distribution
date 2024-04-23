import ballerina/io;
import ballerina/soap.soap12;

xmlns "http://tempuri.org/" as quer;

public function main() returns error? {
    int additionA = 37;
    int additionB = 73;

    soap12:Client soapClient = check new ("http://www.dneonline.com/calculator.asmx?WSDL");
    xml body = xml `<soap:Envelope
                        xmlns:soap="http://www.w3.org/2003/05/soap-envelope"
                        soap:encodingStyle="http://www.w3.org/2003/05/soap-encoding">
                        <soap:Body>
                        <quer:Add xmlns:quer="http://tempuri.org/">
                            <quer:intA>${additionA}</quer:intA>
                            <quer:intB>${additionB}</quer:intB>
                        </quer:Add>
                        </soap:Body>
                    </soap:Envelope>`;

    // `sendOnly()` fires and forgets a request.
    check soapClient->sendOnly(body, "http://tempuri.org/Add");

    // `sendReceive()` sends a request to a SOAP endpoint
    // and receives the response in `xml` or `mime:Entity[]` format.
    xml response = check soapClient->sendReceive(body, "http://tempuri.org/Add");
    xml result = response/**/<quer:AddResult>/*;
    io:println(string `Sum: ${additionA} + ${additionB} = `, result);
}
