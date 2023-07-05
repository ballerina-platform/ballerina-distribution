import ballerina/constraint;
import ballerina/graphql;

public type Profile record {|
    // Define constraints for the fields
    @constraint:String {
        maxLength: 5
    }
    string name;

    @constraint:Int {
        minValue: 0
    }
    int age;

    @constraint:Float {
        maxValue: 3.0
    }
    float height;
|};

service /graphql on new graphql:Listener(9090) {

    resource function get name(Profile profile) returns string {
        return profile.name;
    }
}
