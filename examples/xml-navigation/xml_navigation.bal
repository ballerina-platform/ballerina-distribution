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

    // `x.<para>` - every element in `x` named `para`.
    xml a = x.<items>;
    io:println(a);

    // `x/*` - for every element `e` in `x`, the children of `e`.
    xml b = x/*;
    io:println(b);

    // `x/<para>` - for every element `e` in `x`, every element named para in the children of `e`.
    xml c = x/<planner>;
    io:println(c);

    // `x/<th|td>` - for every element `e` in `x`, every element named `th` or `td` in the 
    // children of `e`.
    xml d = x/<planner|pen>;
    io:println(d);

    // `x/<*>` - for every element `e` in `x`, every element in the children of `e`.
    xml e = x/<*>;
    io:println(e);

    // x/**/<para>  - for every element `e` in `x`, every element named `para` in 
    // the descendants of `e`.
    xml f = x/**/<name>;
    io:println(f);

    // x/<para>[0]  - for every element `e` in `x`, first element named `para` in 
    // The children of `e`.
    xml g = x/<book>[0];
    io:println(g);

}
