import ballerina/io;

import ballerinax/activemq.driver as _;
import ballerinax/java.jms;

public function main() returns error? {
    jms:Connection connection = check new (
        initialContextFactory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory",
        providerUrl = "tcp://localhost:61616"
    );
    jms:Session session = check connection->createSession(jms:CLIENT_ACKNOWLEDGE);
    jms:MessageConsumer consumer = check session.createConsumer(destination = {
        'type: jms:QUEUE,
        name: "order-queue"
    });
    jms:Message? message = check consumer->receive(5000);
    if message is jms:MapMessage {
        map<anydata> payload = message.content;
        int|error orderId = payload["orderId"].ensureType();
        if orderId is int {
            io:println("Received message from the JMS provider", orderId);
            check consumer->acknowledge(message);
        }
    }
}
