import bc2testorg/<PKG_A> as pkgA;
import bc2testorg/<PKG_B> as pkgB;


public function main() {
    int sum = pkgA:testSum();
    string helloStr = pkgB:hello("Package C");
}

public function printHelloWithSum(string name) returns string {
    return pkgB:hello(name) + ":" + pkgA:testSum().toString();
}

