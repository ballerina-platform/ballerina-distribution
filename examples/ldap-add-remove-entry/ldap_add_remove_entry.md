# LDAP client - Add/Remove entries

The `ldap:Client` connects to a directory server and performs various operations on directories. Currently, it supports the generic LDAP operations; `add`, `modify`, `modifyDN`, `compare`, `search`, `searchWithType`, `delete`, and `close`.

The `add` operation creates a new entry in a directory server. It requires a `DN` (Distinguished Name) for the entry and the attributes to be included. The `objectClass` attribute must be specified to define the object classes for the entry, and any attributes required by these object classes should also be included.

The `delete` operation removes an entry from a directory server. It requires a `DN` (Distinguished Name) of the entry to be deleted.

::: code ldap_add_remove_entry.bal :::

## Prerequisites
- Ensure that an LDAP server is up and running locally on port 389 while running the example.

- Run the example by executing the command below.

::: out ldap_add_remove_entry.server.out :::

## Related links
- [`ldap:Client` `add` operation - API documentation](https://central.ballerina.io/ballerina/ldap/latest#Client-add)
- [`ldap:Client` `delete` operation - API documentation](https://central.ballerina.io/ballerina/ldap/latest#Client-delete)
- [`ldap` module - API documentation](https://lib.ballerina.io/ballerina/ldap/latest/)
- [`ldap:Client` - Specification](/spec/ldap/#2-ldap-client)
