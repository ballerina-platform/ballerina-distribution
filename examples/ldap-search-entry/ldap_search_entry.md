# LDAP Client - Seacrh for an entry

The `ldap:Client` connects to a directory server and performs various operations on directories. Currently, it supports the main LDAP operations; `add`, `modify`, `modifyDN`, `compare`, `search`, `searchWithType`, `delete`, and `close`.

The `search` operation is used to retrieve entries that match specified criteria. The components of an LDAP search request include:

- `baseDN`: Defines the base of the subtree for the search.
- `filter`: Specifies the criteria that entries must meet.
- `scope`: Determines extent of the the search coverage within the subtree.

When a directory server processes a valid search request, it finds entries within the defined scope that meet the filter criteria. The matching entries are then returned to the client in a `ldap:SearchResult` record.

::: code ldap_search_entry.bal :::

## Prerequisites
- Make sure to keep an LDAP server up and running while running the example.

- Run the example by executing the command below.

::: out ldap_search_entry.server.out :::

## Related links
- [`ldap:Client` - API documentation](https://lib.ballerina.io/ballerina/ldap/latest#Client)
- [`ldap` module - API documentation](https://lib.ballerina.io/ballerina/ldap/latest/)
