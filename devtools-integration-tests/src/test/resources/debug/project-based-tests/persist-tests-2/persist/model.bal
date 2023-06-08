import ballerina/persist as _;

type OrderItem record {|
    readonly string orderId;
    readonly string itemId;
    int quantity;
    string notes;
|};
