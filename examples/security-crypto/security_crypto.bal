import ballerina/crypto;
import ballerina/io;
import ballerina/random;

function hash() returns error? {
    // Input value for hash operations.
    string value = "Hello Ballerina!";
    byte[] input = value.toBytes();

    // Hashing input value using the [MD5 hashing algorithm](https://docs.central.ballerina.io/ballerina/crypto/latest/functions#hashMd5), and printing the hash value using the Hex encoding.
    byte[] output = crypto:hashMd5(input);
    io:println("Hex encoded hash with MD5: " + output.toBase16());

    // Hashing the input value using the SHA1 hashing algorithm, and printing the hash value using the Base64 encoding.
    output = crypto:hashSha1(input);
    io:println("Base64 encoded hash with SHA1: " + output.toBase64());

    // Hashing the input value using the SHA256 hashing algorithm, and printing the hash value using the Hex encoding.
    output = crypto:hashSha256(input);
    io:println("Hex encoded hash with SHA256: " + output.toBase16());

    // Hashing the input value using the SHA384 hashing algorithm, and printing the hash value using the Base64 encoding.
    output = crypto:hashSha384(input);
    io:println("Base64 encoded hash with SHA384: " + output.toBase64());

    // Hashing the input value using the SHA512 hashing algorithm, and printing the hash value using the Hex encoding.
    output = crypto:hashSha512(input);
    io:println("Hex encoded hash with SHA512: " + output.toBase16());

    // The Hex-encoded CRC32B checksum generation for the input value.
    io:println("CRC32B for text: " + crypto:crc32b(input));
}

function hmac() returns error? {
    // Input value for HMAC operations.
    string value = "Hello Ballerina!";
    byte[] input = value.toBytes();

    // The key used for the HMAC generation.
    string secret = "somesecret";
    byte[] key = secret.toBytes();

    // HMAC generation for the input value using the MD5 hashing algorithm, and printing the HMAC value using the Hex encoding.
    byte[] output = check crypto:hmacMd5(input, key);
    io:println("Hex encoded HMAC with MD5: " + output.toBase16());

    // HMAC generation for input the value using the SHA1 hashing algorithm, and printing the HMAC value using the Base64 encoding.
    output = check crypto:hmacSha1(input, key);
    io:println("Base64 encoded HMAC with SHA1: " + output.toBase64());

    // HMAC generation for the input value using the SHA256 hashing algorithm, and printing the HMAC value using the Hex encoding.
    output = check crypto:hmacSha256(input, key);
    io:println("Hex encoded HMAC with SHA256: " + output.toBase16());

    // HMAC generation for the input value using the SHA384 hashing algorithm, and printing the HMAC value using the Base64 encoding.
    output = check crypto:hmacSha384(input, key);
    io:println("Base64 encoded HMAC with SHA384: " + output.toBase64());

    // HMAC generation for the input value using the SHA512 hashing algorithm, and printing the HMAC value using the Hex encoding.
    output = check crypto:hmacSha512(input, key);
    io:println("Hex encoded HMAC with SHA512: " + output.toBase16());
}

function decodePrivateKey() returns crypto:PrivateKey|error {
    // Obtaining the reference to an RSA private key by a key file.
    string keyFile = "../resource/path/to/private.key";
    crypto:PrivateKey privateKey =
        check crypto:decodeRsaPrivateKeyFromKeyFile(keyFile);

    // Obtaining the reference to an RSA private key by an encrypted key file.
    string encryptedKeyFile = "../resource/path/to/encryptedPrivate.key";
    privateKey = check crypto:decodeRsaPrivateKeyFromKeyFile(encryptedKeyFile,
                                                         "ballerina");

    // Obtaining the reference to an RSA private key stored within a PKCS#12 or PFX format archive file.
    crypto:KeyStore keyStore = {
        path: "../resource/path/to/ballerinaKeystore.p12",
        password: "ballerina"
    };
    privateKey = check crypto:decodeRsaPrivateKeyFromKeyStore(keyStore,
                                              "ballerina", "ballerina");

    return privateKey;
}

function decodePublicKey() returns crypto:PublicKey|error {
    // Obtaining the reference to an RSA public key by a cert file.
    string certFile = "../resource/path/to/public.crt";
    crypto:PublicKey publicKey =
        check crypto:decodeRsaPublicKeyFromCertFile(certFile);

    // Obtaining reference to a RSA public key stored within a PKCS#12 or PFX format archive file.
    crypto:TrustStore trustStore = {
        path: "../resource/path/to/ballerinaTruststore.p12",
        password: "ballerina"
    };
    publicKey = check crypto:decodeRsaPublicKeyFromTrustStore(trustStore,
                                                             "ballerina");

    return publicKey;
}

function sign() returns error? {
    // Input value for the `sign` operations.
    string value = "Hello Ballerina!";
    byte[] input = value.toBytes();

    // Private and public keys for the `sign` and `verify` operations.
    crypto:PrivateKey privateKey = check decodePrivateKey();
    crypto:PublicKey publicKey = check decodePublicKey();

    // Signing the input value using the RSA-MD5 signature algorithms, and printing the signature value using the Hex encoding.
    byte[] output = check crypto:signRsaMd5(input, privateKey);
    io:println("Hex encoded RSA-MD5 signature: " + output.toBase16());

    boolean verified =
        check crypto:verifyRsaMd5Signature(input, output, publicKey);
    io:println("RSA-MD5 signature verified: " + verified.toString());

    // Signing the input value using the RSA-MD5 signature algorithms, and printing the signature value using the Base64 encoding.
    output = check crypto:signRsaSha1(input, privateKey);
    io:println("Base64 encoded RSA-SHA1 signature: " + output.toBase64());

    verified = check crypto:verifyRsaSha1Signature(input, output, publicKey);
    io:println("RSA-SHA1 signature verified: " + verified.toString());

    // Signing the input value using the RSA-MD5 signature algorithms, and printing the signature value using the Hex encoding.
    output = check crypto:signRsaSha256(input, privateKey);
    io:println("Hex encoded RSA-SHA256 signature: " + output.toBase16());

    verified = check crypto:verifyRsaSha256Signature(input, output, publicKey);
    io:println("RSA-SHA256 signature verified: " + verified.toString());

    // Signing the input value using the RSA-MD5 signature algorithms, and printing the signature value using the Base64 encoding.
    output = check crypto:signRsaSha384(input, privateKey);
    io:println("Base64 encoded RSA-SHA384 signature: " + output.toBase64());

    verified = check crypto:verifyRsaSha384Signature(input, output, publicKey);
    io:println("RSA-SHA384 signature verified: " + verified.toString());

    // Signing the input value using the RSA-MD5 signature algorithms, and printing the signature value using the Hex encoding.
    output = check crypto:signRsaSha512(input, privateKey);
    io:println("Hex encoded RSA-SHA512 signature: " + output.toBase16());

    verified = check crypto:verifyRsaSha512Signature(input, output, publicKey);
    io:println("RSA-SHA512 signature verified: " + verified.toString());
}

function encrypt() returns error? {
    // Input value for the `encrypt` operations.
    string value = "Hello Ballerina!";
    byte[] input = value.toBytes();

    // Private and public keys for the `encrypt` and `decrypt` operations.
    crypto:PrivateKey privateKey = check decodePrivateKey();
    crypto:PublicKey publicKey = check decodePublicKey();

    // Encrypts and decrypts an input value using the `RSA ECB PKCS1` padding.
    byte[] output = check crypto:encryptRsaEcb(input, publicKey);
    output = check crypto:decryptRsaEcb(output, privateKey);
    io:println("RSA ECB PKCS1 decrypted value: " +
        check string:fromBytes(output));

    // Encrypts and decrypts an input value using the `RSA ECB OAEPwithSHA512andMGF1` padding.
    output = check crypto:encryptRsaEcb(input, publicKey,
                                        crypto:OAEPwithSHA512andMGF1);
    output = check crypto:decryptRsaEcb(output, privateKey,
                                        crypto:OAEPwithSHA512andMGF1);
    io:println("RSA ECB OAEPwithSHA512andMGF1 decrypted value: " +
        check string:fromBytes(output));

    // Randomly generates a 128 bit key for the AES encryption.
    byte[16] aesKey = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    foreach var i in 0 ... 15 {
        aesKey[i] = <byte>(check random:createIntInRange(0, 255));
    }

    // Randomly generates a 128 bit IV for the AES encryption.
    byte[16] iv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    foreach var i in 0 ... 15 {
        iv[i] = <byte>(check random:createIntInRange(0, 255));
    }

    // Encrypts and decrypts an input value using the `AES CBC PKCS5` padding.
    output = check crypto:encryptAesCbc(input, aesKey, iv);
    output = check crypto:decryptAesCbc(output, aesKey, iv);
    io:println("AES CBC PKCS5 decrypted value: " +
        check string:fromBytes(output));

    // Encrypts and decrypts an input value using the `AES CBC` without padding.
    output = check crypto:encryptAesCbc(input, aesKey, iv, crypto:NONE);
    output = check crypto:decryptAesCbc(output, aesKey, iv, crypto:NONE);
    io:println("AES CBC no padding decrypted value: " +
        check string:fromBytes(output));

    // Encrypts and decrypts an input value using the `AES GCM PKCS5` padding.
    output = check crypto:encryptAesGcm(input, aesKey, iv);
    output = check crypto:decryptAesGcm(output, aesKey, iv);
    io:println("AES GCM PKCS5 decrypted value: " +
        check string:fromBytes(output));

    // Encrypts and decrypts an input value using the `AES GCM` without padding.
    output = check crypto:encryptAesGcm(input, aesKey, iv, crypto:NONE);
    output = check crypto:decryptAesGcm(output, aesKey, iv, crypto:NONE);
    io:println("AES GCM no padding decrypted value: " +
        check string:fromBytes(output));

    // Encrypts and decrypts an input value using the `AES ECB PKCS5 padding`.
    output = check crypto:encryptAesEcb(input, aesKey);
    output = check crypto:decryptAesEcb(output, aesKey);
    io:println("AES ECB PKCS5 decrypted value: " +
        check string:fromBytes(output));

    // Encrypts and decrypts an input value using the `AES ECB` without padding.
    output = check crypto:encryptAesEcb(input, aesKey, crypto:NONE);
    output = check crypto:decryptAesEcb(output, aesKey, crypto:NONE);
    io:println("AES ECB no padding decrypted value: " +
        check string:fromBytes(output));
}

public function main() returns error? {
    check hash();
    check hmac();
    check sign();
    check encrypt();
}
