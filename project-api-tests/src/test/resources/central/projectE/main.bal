import bctestorg/<PKG_A> as pkgA;
import bctestorg/<PKG_B> as pkgB;


public function main() {
    _ = pkgA:testSum();
    _ = pkgB:hello("Package C");
}

public function printHelloWithSum(string name) returns string {
    return pkgB:hello(name) + ":" + pkgA:testSum().toString();
}
