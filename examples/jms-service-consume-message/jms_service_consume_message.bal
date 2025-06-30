import ballerinax/java.jms;
import ballerina/log;
import ballerinax/activemq.driver as _;

listener jms:Listener jmsListener = check new (
    initialContextFactory = "org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl = "tcp://localhost:61616"
);

@jms:ServiceConfig {
   subscriptionConfig: {
      queueName: "order-queue"
   }
}
service on jmsListener {
    remote function onMessage(jms:Message message) returns error? {
        if message is jms:MapMessage {
            log:printInfo("Order message received", content = message.content);
        }
    }
}
