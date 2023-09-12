import ballerinax/java.jms;
import ballerina/log;
import ballerinax/activemq.driver as _;

service on new jms:Listener(
    connectionConfig = {
        initialContextFactory: "org.apache.activemq.jndi.ActiveMQInitialContextFactory",
        providerUrl: "tcp://localhost:61616"
    },
    consumerOptions = {
        destination: {
            'type: jms:QUEUE,
            name: "order-queue"
        }
    }
) {
    remote function onMessage(jms:Message message) returns error? {
        if message is jms:MapMessage {
            log:printInfo("Order message received", content = message.content);
        }
    }
}
