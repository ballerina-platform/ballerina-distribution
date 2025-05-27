# Change Data Capture Ballerina By Example - Prerequisites and Test Data

The Change Data Capture (CDC) BBEs are based on a fraud detection use case.

## Setting up the MySQL Databases

To set up the required MySQL databases for the BBEs, run the following Ballerina files using the command `bal run`:

1. `setup_finance_db.bal` – Creates the `finance_db` database and its tables.
2. `setup_store_db.bal` – Creates the `store_db` database and its tables.

## Inserting Test Data

To insert test data for the CDC service BBEs, run the following files with `bal run`:

1. `test_cdc_service.bal` – Inserts records into the `finance_db.transactions` table.
2. `test_cdc_advanced_service.bal` – Inserts additional records for advanced CDC scenarios.
