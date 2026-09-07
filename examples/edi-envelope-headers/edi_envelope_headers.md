# Read EDI envelope headers

An EDI interchange carries its routing information in the envelope headers: the ISA and GS segments in X12, and UNB and UNH in EDIFACT. The Ballerina `edi` library reads those segments without a schema, so a trading partner can be identified before deciding how, or whether, to parse the rest of the document.

`x12HeadersFromEdiString` and `edifactHeadersFromEdiString` read the headers from EDI text. `x12HeadersFromEdiFile` and `edifactHeadersFromEdiFile` do the same for a file, reading only its first 512 characters.

For more information on the underlying module, see the [`edi` module](https://lib.ballerina.io/ballerina/edi/latest/).

::: code edi_envelope_headers.bal :::

Run the program by executing the following command.

::: out edi_envelope_headers.out :::
