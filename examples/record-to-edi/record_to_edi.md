# Record to EDI conversion

The same prebuilt package used in the EDI to record conversion example serializes in the other direction: build the typed record for the message and call `toEdiString` to get EDI text for an outbound document.

`toEdiString` writes the message body. Wrap it in an envelope with `interchangeToEdiString`, which emits the `UNB`/`UNH` headers and recomputes the `UNT` and `UNZ` counts, when a full interchange is needed.

::: code record_to_edi.bal :::

Run the program using the command below.

::: out output.out :::

The output is the same message that the EDI to record conversion example reads back, so the two examples form a round trip.
