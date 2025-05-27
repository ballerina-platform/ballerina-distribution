# Change Data Capture - Group Events by Table

The `cdc:Service` connects to a MySQL database using the `mysql:CdcListener`, allowing you to handle change data capture (CDC) events as typed records. The listener detects database changes and calls the relevant remote method (`onRead`, `onCreate`, `onUpdate`, or `onDelete`) in your service, passing the event data.

You can attach multiple `cdc:Service` instances to a single `mysql:CdcListener`. This lets you group related event handling logic into separate services, making your code easier to organize and maintain. Each service can focus on a specific set of tables or event types, improving readability and separation of concerns.

::: code cdc_advanced_service.bal :::

## Prerequisites

- To set up the database, see the [Change Data Capture Ballerina By Example - Prerequisites and Test Data](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/cdc-prerequisite).

Run the program by executing the following command.

::: out cdc_advanced_service.out :::

> **Tip:** To insert additional records for testing, run the `test_cdc_advance_listener.bal` file provided in the [Change Data Capture Ballerina By Example - Prerequisites and Test Data](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/cdc-prerequisite).

## Related links
- [`mysql:CdcListener` - API documentation](https://lib.ballerina.io/ballerinax/mysql/latest#CdcListener)
- [`cdc:Service` - API documentation](https://lib.ballerina.io/ballerinax/cdc/latest#Service)
- [`cdc:Service` - Specification](https://github.com/ballerina-platform/module-ballerinax-cdc/blob/main/docs/spec/spec.md#22-service)
