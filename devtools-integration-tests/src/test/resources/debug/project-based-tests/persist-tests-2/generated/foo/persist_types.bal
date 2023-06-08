// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type OrderItem record {|
    readonly string orderId;
    readonly string itemId;
    int quantity;
    string notes;
|};

public type OrderItemOptionalized record {|
    string orderId?;
    string itemId?;
    int quantity?;
    string notes?;
|};

public type OrderItemTargetType typedesc<OrderItemOptionalized>;

public type OrderItemInsert OrderItem;

public type OrderItemUpdate record {|
    int quantity?;
    string notes?;
|};

