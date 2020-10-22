import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public isolated function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    var ret = main();
    test:assertEquals(outputs.length(), 25);
    test:assertEquals(outputs[0], "Hex encoded hash with MD5: 0605402ee16d8e96511a58ff105bc24a");
    test:assertEquals(outputs[1], "Base64 encoded hash with SHA1: /8fwbGIevBvv2Nl3gEL9DtWas+Q=");
    test:assertEquals(outputs[2], "Hex encoded hash with SHA256: a984a643c350b17f0738bac0fef17f2cd91d91e04596351d0af" +
                                  "670c79adc12d5");
    test:assertEquals(outputs[3], "Base64 encoded hash with SHA384: lselzItgAZHQmqNbkf/s2aRjBSd93O3ayc0PB0Dxk6AEo1s4" +
                                  "4zyTz/Qp0FJO1n6b");
    test:assertEquals(outputs[4], "Hex encoded hash with SHA512: a6f0770f1582f49396a97fbd5973ac22a3a578ac6a991786427" +
                                  "dfec17dbd984d8d6289771ac6f44176160a3dcd59f4a8c6b3ab97bef0caa5c67a3fac78c8e946");
    test:assertEquals(outputs[5], "CRC32B for text: db9230c5");
    test:assertEquals(outputs[6], "CRC32 for xml content: 7d5c0879");
    test:assertEquals(outputs[7], "Hex encoded HMAC with MD5: b69fa2cc698e0923a7eea9d8f2b156fe");
    test:assertEquals(outputs[8], "Base64 encoded HMAC with SHA1: AkWFajkb/gml703Zf4pPgxrjam4=");
    test:assertEquals(outputs[9], "Hex encoded HMAC with SHA256: 13a3369b8ba326fd311d4500b06a5214a02ed2a033917108f6b" +
                                  "9af58b7ede381");
    test:assertEquals(outputs[10], "Base64 encoded HMAC with SHA384: 0AjKoWLhNPgdobGTPJs0PdkA0W9wkJtzUvXigzC1ZmXDJJsx" +
                                  "p4icks4JrPiwHGm6");
    test:assertEquals(outputs[11], "Hex encoded HMAC with SHA512: 27588ad08e772a6bba5fca5f45cf467819c8de69a70a42be6fe" +
                                  "3eb09ceb3bfeb8b2976bda8ea5c10dcfa2294b12cb0b50b22a06309bada98af21857904a03205");

    test:assertEquals(outputs[12], "Hex encoded RSA-MD5 signature: 2cfd121e4ff2409d1b2482ebbf37d0c035884d6d858e307e4" +
                                   "460b092d79cb20abb624a0dfae76b73b1fc85447be3060a36b318813f0115b1919e5efa7a7f9b117" +
                                   "3ec869f56fd9448d99770e1565db1c69a04fd0075fa0e33423a7e829a8b9c25a4dd2c68f3eee021c" +
                                   "0c4ff27979750b395384e280afd87af5274c8d2d99ad4438d9bfc9b2c5a2814212ba29ce6ff70cbe" +
                                   "30a5c23f86b0330e143c4d8813ff10092cd313c6861706d37df5f4bb4e9fc72354975ee1786cf24c" +
                                   "79b9edfa909968f198c4da37464f3d214a68fb39956717e92d667bb5a9a7f5986ba055d431813d40" +
                                   "53a028873499f98c94fd6b5c6fd5aefad432669f957ab4ce9e91c5e77b36ec0");
    test:assertEquals(outputs[13], "RSA-MD5 signature verified: true");
    test:assertEquals(outputs[14], "Base64 encoded RSA-SHA1 signature: bYMHKKVkjbOUp9ly3AdW9/euxF94krkkF9SDk2FfbVEc0" +
                                   "mqpGIxVoZlPiFxszurZF1YPcqOSeOehDkaHXUMfQkTjBq7XlcePtkywy0fChqw8/SWqZR8nbYv97tt8+" +
                                   "MVTkymbm26syQLwYNLiGp/EsN6X+fJpkdakwHE+TrdE+rEFrNysGyAm1DWwc4c+l7MEmSYMUnh/GWPY5" +
                                   "r2knOOdDA3mr+XyrsxzFRWZgO7ebVvEQfq9XkRp8kdiGVgpLS5au0jKj3EpbCdS1prFgy3grkuSJTTUQ" +
                                   "CwgPo7WSjWbuehFGni7rbas8HIqNlyWF0qUyznJ3eqbUwZ95QqOoVWZoQ==");
    test:assertEquals(outputs[15], "RSA-SHA1 signature verified: true");
    test:assertEquals(outputs[16], "Hex encoded RSA-SHA256 signature: 215c6ea96c9e82348430c6bb02e715560b4fbd3afcf24f" +
                                   "beb41ff12d4d68a797d61c4d6f822807688e4dc604e212b3cc7ac563b3cbe4e5690e2aebaf4e3df3" +
                                   "5c19d4b0f7043f50501f390634303577053b029d495104c0e98bc887f0be744ef6f726f719201907" +
                                   "ad4e86cef82eb030b60c384f7034a85159081e598e197bb8904a9123f39d190796dc7fd946157547" +
                                   "c10523999b8fa956d4119dbfe3c1435911c0585cf3c537964516706772e87f247055740cc4867ac6" +
                                   "b99d7bf699fce1b59956c7f55368c8c88c9d47e51ef120ed3f27c3e555691a697142c78cbd72c23b" +
                                   "81b43fa5ab67164a35f8e8c6bf1da187d3feb866add13f1fb9576a2f7887535311");
    test:assertEquals(outputs[17], "RSA-SHA256 signature verified: true");
    test:assertEquals(outputs[18], "Base64 encoded RSA-SHA384 signature: BjQ40dffGiRQ4zo1s+ld+zKhJL21RbO5sW3L2+4xmon" +
                                   "Ut126u9D4/FZ2sM1QGGamj8btB9otiYmWr9sFm4fTs1EX6vrxcCGCAiDdkMxiRs7kShaz2x/BjJQ7cOd" +
                                   "9OY+amwo7DQ/FAk9mNOt4lFUpjc9WyEW9F1PEJRXZQvMmVabDu8lp/Fh02lmEquG15DT5qT0jRxRJiS8" +
                                   "CNa+97cMZdOmF2KeADfRbNJSz70mZ76MrsNxYIXYIiJzJBQod0efQr0Sr/HDn4JDVph9rpDM3p8m94Ty" +
                                   "XvSOwxwxzZWRLEwB0ANdfDmbrW4bOpxfZZFmy1hltqNJQ9G0BcKOHsZDj6Q==");
    test:assertEquals(outputs[19], "RSA-SHA384 signature verified: true");
    test:assertEquals(outputs[20], "Hex encoded RSA-SHA512 signature: 15428fdc7b26d18b1f3eae4569399ae6ebfd430c8f073b" +
                                   "f2fa77ebfe1ad5645640374ea4a4aeadd252af3a198e55e69ad2a910e28470d9b54748887de06a5c" +
                                   "3ed7ab12399a404359332553e051e8ae0f3ef741faa15a21ad17a9c235e5f91d567bcca0e5a61176" +
                                   "89dccada4a33ee897514f7a8a32f12dac0087f5dcbb094c93c792f672e1685618ac5d93aa9d30f6d" +
                                   "8e306145ef2d1b9cfdc04d6c61b43376089a78471e8e03d97ee3b57e1b734a23f44366a99234a0ab" +
                                   "eb1d36d01c474833b4c2beaf430dae06ab95a1c951645fb1e0a5e7b9eed44d40e35036f2cd2764df" +
                                   "6cc04fe1248e1bb772a53c8201a974109333a318ce57930494d4cb5e41d0dc8f1c");
    test:assertEquals(outputs[21], "RSA-SHA512 signature verified: true");
    test:assertEquals(outputs[22], "RSA ECB PKCS1 decrypted value: Hello Ballerina!");
    test:assertEquals(outputs[23], "RSA ECB OAEPwithSHA512andMGF1 decrypted value: Hello Ballerina!");
    test:assertEquals(outputs[24], "AES CBC PKCS5 decrypted value: Hello Ballerina!");
    test:assertEquals(outputs[25], "AES CBC no padding decrypted value: Hello Ballerina!");
    test:assertEquals(outputs[26], "AES GCM PKCS5 decrypted value: Hello Ballerina!");
    test:assertEquals(outputs[27], "AES GCM no padding decrypted value: Hello Ballerina!");
    test:assertEquals(outputs[28], "AES ECB PKCS5 decrypted value: Hello Ballerina!");
    test:assertEquals(outputs[29], "AES ECB no padding decrypted value: Hello Ballerina!");
}
