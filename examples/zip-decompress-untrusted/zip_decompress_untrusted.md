# Unpack an untrusted archive

An archive that arrives from outside the system is read defensively. `zip:ExtractionLimits` caps the number of entries, the total unpacked size, and how far a single entry may expand beyond the size it stores, so an archive built to exhaust the disk is stopped rather than unpacked. Each refusal carries its own error type: a `zip:LimitExceededError` for an archive that outgrows the limits, a `zip:UnsafePathError` for an entry whose name would write outside the target directory, and a `zip:UnsupportedEntryError` for an entry that is encrypted or stored with a compression method the library cannot read.

For more information on the underlying module, see the [`zip` module](https://lib.ballerina.io/ballerina/zip/latest/).

::: code zip_decompress_untrusted.bal :::

::: out zip_decompress_untrusted.out :::
