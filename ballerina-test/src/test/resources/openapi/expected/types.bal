public type CustomerCustomerBody record {
    CustomerAddress address?;
    # An integer amount in %s that represents the customer's current balance, which affect the customer's future invoices. A negative amount represents a credit that decreases the amount due on an invoice; a positive amount increases the amount due on an invoice.
    int balance?;
};

public type Customer record {
    # The customer's address.
    CustomerAddress? address?;
    string name?;
};

public type CustomerAddress record {
    string city?;
    string country?;
    string line1?;
    string line2?;
    string postal_code?;
    string state?;
};
