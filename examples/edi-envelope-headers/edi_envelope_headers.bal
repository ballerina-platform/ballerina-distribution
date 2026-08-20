import ballerina/edi;
import ballerina/io;

// An X12 interchange. The ISA segment is fixed-width: every element is padded to its
// standard length, which makes the segment exactly 106 characters.
final string x12Order = "ISA*00*          *00*          *ZZ*SUPERMART      *ZZ*SUPPLIER456    " +
    "*260101*1200*U*00401*000000001*0*P*>~" +
    "GS*PO*SUPERMART*SUPPLIER456*20260101*1200*1*X*004010~ST*850*0001~SE*2*0001~GE*1*1~IEA*1*000000001~";

// The same interchange in EDIFACT, where the envelope is UNB/UNZ around UNH/UNT.
final string edifactOrder = "UNB+UNOA:3+SUPERMART:14+SUPPLIER456:14+260101:1200+REF2'" +
    "UNH+0001+ORDERS:D:03A:UN'UNT+2+0001'UNZ+1+REF2'";

public function main() returns error? {
    // Read the X12 ISA segment, and the GS segment that follows it. No schema is
    // involved: the standard envelope layout is built into these functions.
    edi:X12Headers x12 = check edi:x12HeadersFromEdiString(x12Order);
    io:println(string `X12: ${x12.isa.senderId} -> ${x12.isa.receiverId}, control number ${x12.isa.controlNumber}`);
    edi:X12GS? gs = x12.gs;
    if gs is edi:X12GS {
        io:println(string `     group ${gs.functionalIdentifier}, version ${gs.version}`);
    }

    // The EDIFACT counterpart reads UNB, and UNH when one follows. A UNA service string
    // advice is honoured when present, including partner-specific delimiters.
    edi:EdifactHeaders edifact = check edi:edifactHeadersFromEdiString(edifactOrder);
    io:println(string `EDIFACT: ${edifact.unb.sender.id} -> ${edifact.unb.recipient.id}, reference ${edifact.unb.controlRef}`);
    edi:EdifactUNH? unh = edifact.unh;
    if unh is edi:EdifactUNH {
        io:println(string `         message ${unh.messageIdentifier.messageType} ${unh.messageIdentifier.version}${unh.messageIdentifier.release}`);
    }
}
