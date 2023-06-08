// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/jballerina.java;
import ballerinax/persist.inmemory;

const ORDER_ITEM = "orderitems";
final isolated table<OrderItem> key(orderId, itemId) orderitemsTable = table [];

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final map<inmemory:InMemoryClient> persistClients;

    public isolated function init() returns persist:Error? {
        final map<inmemory:TableMetadata> metadata = {
            [ORDER_ITEM] : {
                keyFields: ["orderId", "itemId"],
                query: queryOrderitems,
                queryOne: queryOneOrderitems
            }
        };
        self.persistClients = {[ORDER_ITEM] : check new (metadata.get(ORDER_ITEM).cloneReadOnly())};
    }

    isolated resource function get orderitems(OrderItemTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get orderitems/[string orderId]/[string itemId](OrderItemTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post orderitems(OrderItemInsert[] data) returns [string, string][]|persist:Error {
        [string, string][] keys = [];
        foreach OrderItemInsert value in data {
            lock {
                if orderitemsTable.hasKey([value.orderId, value.itemId]) {
                    return <persist:AlreadyExistsError>error("Duplicate key: " + [value.orderId, value.itemId].toString());
                }
                orderitemsTable.put(value.clone());
            }
            keys.push([value.orderId, value.itemId]);
        }
        return keys;
    }

    isolated resource function put orderitems/[string orderId]/[string itemId](OrderItemUpdate value) returns OrderItem|persist:Error {
        lock {
            if !orderitemsTable.hasKey([orderId, itemId]) {
                return <persist:NotFoundError>error("Not found: " + [orderId, itemId].toString());
            }
            OrderItem orderitem = orderitemsTable.get([orderId, itemId]);
            foreach var [k, v] in value.clone().entries() {
                orderitem[k] = v;
            }
            orderitemsTable.put(orderitem);
            return orderitem.clone();
        }
    }

    isolated resource function delete orderitems/[string orderId]/[string itemId]() returns OrderItem|persist:Error {
        lock {
            if !orderitemsTable.hasKey([orderId, itemId]) {
                return <persist:NotFoundError>error("Not found: " + [orderId, itemId].toString());
            }
            return orderitemsTable.remove([orderId, itemId]).clone();
        }
    }

    public isolated function close() returns persist:Error? {
        return ();
    }
}

isolated function queryOrderitems(string[] fields) returns stream<record {}, persist:Error?> {
    table<OrderItem> key(orderId, itemId) orderitemsClonedTable;
    lock {
        orderitemsClonedTable = orderitemsTable.clone();
    }
    return from record {} 'object in orderitemsClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneOrderitems(anydata key) returns record {}|persist:NotFoundError {
    table<OrderItem> key(orderId, itemId) orderitemsClonedTable;
    lock {
        orderitemsClonedTable = orderitemsTable.clone();
    }
    from record {} 'object in orderitemsClonedTable
    where persist:getKey('object, ["orderId", "itemId"]) == key
    do {
        return {
            ...'object
        };
    };
    return <persist:NotFoundError>error("Invalid key: " + key.toString());
}
