import ballerina/io;
import ballerinax/java.jms;
import ballerinax/activemq.driver as _;

public function main() returns error? {
    jms:Connection connection = check new (
        initialContextFactory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory",
        providerUrl = "tcp://localhost:61616"
    );
    jms:Session session = check connection->createSession();
    jms:MessageConsumer consumer = check session.createConsumer(destination = {
        'type: jms:QUEUE,
        name: "order-queue"
    });
    jms:Message? message = check consumer->receive(5000);
    if message is jms:MapMessage {
        io:println("Received message from the JMS provider", message);
    }
}
