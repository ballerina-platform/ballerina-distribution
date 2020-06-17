import ballerina/io;

public function main() {
    // The `xml` element with nested children.
    xml school = xml `<school>
                        <student>
                           <firstName>Alex</firstName>
                           <lastName>George</lastName>
                           <intakeYear>2020</intakeYear>
                           <score>1.5</score>
                        </student>
                        <student>
                           <firstName>Ranjan</firstName>
                           <lastName>Fonseka</lastName>
                           <intakeYear>2020</intakeYear>
                           <score>0.9</score>
                        </student>
                        <student>
                           <firstName>John</firstName>
                           <lastName>David</lastName>
                           <intakeYear>2022</intakeYear>
                           <score>1.5</score>
                        </student>
                      </school>`;

    // The `from` clause works similarly to a `foreach` statement.
    // `authors` is the concatenated `xml` of `query expression` results.
    xml authors = from var x in school/<student>/<firstName>
        // The `select` clause is evaluated for each iteration.
        // The emitted values values are concatenated to form the `xml` result.
        select <xml> x
        // The `limit` clause limits the number of output items.
        limit 2;

    io:println(authors);
}
