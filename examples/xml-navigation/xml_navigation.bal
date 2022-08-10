import ballerina/io;

public function main() {
    xml x = xml 
        `<items>
            <!--Contents-->
            <book>
                <name>A Study in Scarlet</name>
                <author><name>Arthur Conan Doyle</name></author>
            </book>
            <planner>Daily Planner<kind>day</kind><pages>365</pages></planner>
            <book>
                <name>The Sign of Four</name>
                <author><name>Arthur Conan Doyle</name></author>
            </book>
            <pen><kind>marker</kind><color>blue</color></pen>
        </items>`;

    // `x.<items>` - every element in `x` named `items`.
    xml a = x.<items>;
    io:println(a);

    // `x/*` - for every element `e` in `x`, the children of `e`.
    xml b = x/*;
    io:println(b);

    // `x/<planner>` - for every element `e` in `x`, every element named `planner` in the children of `e`.
    xml c = x/<planner>;
    io:println(c);

    // `x/<planner|pen>` - for every element `e` in `x`, every element named `planner` or `pen` in the
    // children of `e`.
    xml d = x/<planner|pen>;
    io:println(d);

    // `x/<*>` - for every element `e` in `x`, every element in the children of `e`.
    xml e = x/<*>;
    io:println(e);

    // x/**/<name>  - for every element `e` in `x`, every element named `name` in
    // the descendants of `e`.
    xml f = x/**/<name>;
    io:println(f);

    // x/<book>[0]  - for every element `e` in `x`, first element named `book` in
    // the children of `e`.
    xml g = x/<book>[0];
    io:println(g);

}
