import ballerina/io;

// The `Timezone` is a `readonly` object type.
type TimeZone readonly & object {
   function getOffset(decimal utc) returns decimal;
};

readonly class FixedTimeZone {
    // Include the `readonly` object type named `TypeZone` using object type inclusion.
   *TimeZone;

   // The `decimal` field named offset is read-only because the `decimal` basic type is
   // inherently immutable. 
   decimal offset;

   function init(decimal offset) {
      self.offset = offset;
   }

   function getOffset(decimal utc) returns decimal {
      return self.offset;
   }
}

public function main() {
    // Create a new class object.
    FixedTimeZone timeZone = new(+5.30);

    io:println(timeZone is FixedTimeZone);
    io:println(timeZone is readonly & FixedTimeZone);
}
