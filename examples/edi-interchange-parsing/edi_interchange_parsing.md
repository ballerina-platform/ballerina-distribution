# Parse an EDI interchange

An EDI interchange holds one or more messages inside an envelope. `interchangeFromEdiString` reads the whole hierarchy and returns typed records holding the envelope segments and every message. The prebuilt `ballerinax/edifact.d03a.supplychain` package exposes it for each D03A message type, so a standard interchange needs no schema file and no generated code.

Envelope segments are fail-fast: a malformed `UNB`, `UNH`, `UNT`, or `UNZ` fails the call. Message bodies are fail-safe: a body the schema cannot read leaves its parse error on that message's `body` field, typed `<Message>|error`, and every other message in the interchange still arrives. A batch is therefore never lost to one bad message — the error can be logged or routed to a dead-letter queue while the rest is processed.

For more information on the underlying module, see the [`edi` module](https://lib.ballerina.io/ballerina/edi/latest/).

::: code edi_interchange_parsing.bal :::

Run the program by executing the following command.

::: out edi_interchange_parsing.out :::
