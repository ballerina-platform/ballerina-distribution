# Parse an EDI interchange

An EDI interchange holds one or more transactions inside an envelope. `interchangeFromEdiString` reads the whole hierarchy against a schema that declares an `envelope`, and returns an `edi:EdiInterchange` holding the envelope segments and every transaction.

Envelope segments are fail-fast: a malformed UNB, UNH, UNT, or UNZ fails the call. Transaction bodies are fail-safe: a body the schema cannot read leaves its parse error in `edi:EdiTransaction.body`, typed `json|error`, and every other transaction in the interchange still arrives. A batch is therefore never lost to one bad message — the error can be logged or routed to a dead-letter queue while the rest is processed.

For more information on the underlying module, see the [`edi` module](https://lib.ballerina.io/ballerina/edi/latest/).

::: code edi_interchange_parsing.bal :::

Run the program by executing the following command.

::: out edi_interchange_parsing.out :::
