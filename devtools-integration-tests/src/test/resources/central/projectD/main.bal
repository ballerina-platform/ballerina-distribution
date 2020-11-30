import bc2testorg/<PKG_C> as pkgC;
import ballerina/io;

public function main() {
    string helloStr = pkgC:printHelloWithSum("World");
    io:print(helloStr);
}

