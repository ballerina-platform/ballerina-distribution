# Change Data Capture - Consume events

The `cdc:Service` connects to a MySQL database using the `mysql:CdcListener`, allowing you to bind change data capture (CDC) events directly to subtypes of `record{}`. The listener captures database changes and dispatches them as records to one of the `onRead`, `onCreate`, `onUpdate`, or `onDelete` remote methods in your service. To use this, specify the required payload type as the argument to these methods, which should be a subtype of `record{}`. When new CDC events are received, the method corresponding to the operation is invoked. If the payload does not match the defined type, a `cdc:PayloadBindingError` will be logged. You can customize error handling by implementing the optional `onError` remote method in your service.

::: code cdc_service.bal :::

## Prerequisites
- To set up the database, see the [Change Data Capture Ballerina By Example - Prerequisites and Test Data](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/cdc-prerequisite).

Run the program by executing the following command.

::: out cdc_service.out :::

> **Tip:** To insert additional records for testing, run the `test_cdc_listener.bal` file provided in the [Change Data Capture Ballerina By Example - Prerequisites and Test Data](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/cdc-prerequisite).

## Related links
- [`mysql:CdcListener` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest#CdcListener)
- [`cdc:Service` - API documentation](https://lib.ballerina.io/ballerinax/cdc/latest#Service)
- [`cdc:Service` - Specification](https://github.com/ballerina-platform/module-ballerinax-cdc/blob/main/docs/spec/spec.md)
