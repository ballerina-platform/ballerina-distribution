import ballerina/http;

import ballerinax/activemq.driver as _;
import ballerinax/java.jms;

service / on new http:Listener(9090) {
    private final jms:MessageProducer orderProducer;
    private final jms:Session session;

    function init() returns error? {
        jms:Connection connection = check new (
            initialContextFactory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory",
            providerUrl = "tcp://localhost:61616"
        );
        self.session = check connection->createSession(jms:SESSION_TRANSACTED);
        self.orderProducer = check self.session.createProducer();
    }

    resource function post orders(map<anydata> payoad) returns http:Accepted|error {
        jms:MapMessage message = {
            content: payoad
        };
        do {
            check self.orderProducer->sendTo({'type: jms:QUEUE, name: "order-queue"}, message);
            check self.session->'commit();
            return http:ACCEPTED;
        } on fail error err {
            check self.session->'rollback();
            return err;
        }
    }
}
