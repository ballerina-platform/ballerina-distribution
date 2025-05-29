import ballerina/log;
import ballerinax/cdc;
import ballerinax/mysql;
import ballerinax/mysql.cdc.driver as _;

listener mysql:CdcListener mysqlListener = new (
    database = {
        username: "root",
        password: "Test@123",
        includedDatabases: "store_db"
    }
);

type Entity record {
    int id;
};

type ProductReviews record {
    int product_id;
    int rating;
};

@cdc:ServiceConfig {
    tables: ["store_db.products", "store_db.vendors"]
}
service on mysqlListener {

    remote function onRead(Entity after, string tableName) returns cdc:Error? {
        log:printInfo(`'${tableName}' cache entry created for Id: ${after.id}`);
    }

    remote function onCreate(Entity after, string tableName) returns cdc:Error? {
        log:printInfo(`'${tableName}' cache entry created for Id: ${after.id}`);
    }

    remote function onUpdate(Entity before, Entity after, string tableName) returns cdc:Error? {
        log:printInfo(`'${tableName}' cache entry updated for Id: ${after.id}.`);
    }

    remote function onDelete(Entity before, string tableName) returns cdc:Error? {
        if tableName == "products" {
            log:printInfo(`'products' cache entry deleted for Id: ${before.id}.`);
        } else {
            log:printInfo(`'vendors' cache entry deleted for Id: ${before.id}.`);
        }
    }
}

@cdc:ServiceConfig {
    tables: ["store_db.product_reviews"]
}
service on mysqlListener {

    remote function onRead(ProductReviews after, string tableName) returns cdc:Error? {
        log:printInfo(`'product_tot_rating' cache added for Product Id: ${after.product_id}.`);
        log:printInfo(`'product_reviews' cache entry added for Product Id: ${after.product_id}.`);
    }

    remote function onCreate(ProductReviews after, string tableName) returns cdc:Error? {
        log:printInfo(`'product_tot_rating' cache added for Product Id: ${after.product_id}.`);
        log:printInfo(`'product_reviews' cache entry added for Product Id: ${after.product_id}.`);
    }

    remote function onUpdate(ProductReviews before, ProductReviews after, string tableName) returns cdc:Error? {
        int ratingDiff = after.rating - before.rating;
        log:printInfo(`'product_tot_rating' cache updated for Product Id: ${after.product_id}.`);
    }

    remote function onDelete(ProductReviews before, string tableName) returns cdc:Error? {
        log:printInfo(`'product_tot_rating' cache deleted for Product Id: ${before.product_id}.`);
        log:printInfo(`'product_reviews' cache entry deleted for Product Id: ${before.product_id}.`);
    }
}
