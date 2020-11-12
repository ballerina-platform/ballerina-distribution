import wso2/utils;
import test/foo;

function testAcceptNothingButReturnString() returns handle {
    return utils:getString();
}

public function sayHello() returns string {
   return foo:say("John");
}
