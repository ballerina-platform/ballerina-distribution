import ballerina/io;

// Timezone is a `readonly` object type.
type TimeZone readonly & object {
   function getOffset(decimal utc) returns decimal;
};

readonly class FixedTimeZone {
    // Include `readonly` object type named `TypeZone` using object type inclusion.
   *TimeZone;

   // `final decimal` field named offset. Here, it is readonly because `decimal` basic type is 
   // inherently immutable. 
   final decimal offset;

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