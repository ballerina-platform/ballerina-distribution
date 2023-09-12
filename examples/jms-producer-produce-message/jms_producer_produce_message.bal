import ballerina/http;

import ballerinax/activemq.driver as _;
import ballerinax/java.jms;

service / on new http:Listener(9090) {
    private final jms:MessageProducer orderProducer;

    function init() returns error? {
        jms:Connection connection = check new (
            initialContextFactory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory",
            providerUrl = "tcp://localhost:61616"
        );
        jms:Session session = check connection->createSession();
        self.orderProducer = check session.createProducer({ 
            'type: jms:QUEUE, 
            name: "order-queue" }
        );
    }

    resource function post orders(map<anydata> payoad) returns http:Accepted|error {
        jms:MapMessage message = {
            content: payoad
        };
        check self.orderProducer->send(message);
        return http:ACCEPTED;
    }
}

