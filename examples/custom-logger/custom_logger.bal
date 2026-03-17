import ballerina/log;

final map<int> & readonly logLevelWeight = {
    ERROR: 1000,
    WARN: 900,
    INFO: 800,
    DEBUG: 700
};

// Custom logger implementation that implements the Logger type
public isolated class ApplicationLogger {
    *log:Logger;

    private final string applicationName;
    private final string version;
    private final readonly & log:KeyValues context;
    private log:Level currentLevel;
    private final ApplicationLogger? parent;

    public isolated function init(string applicationName, string version, log:KeyValues context = {}, ApplicationLogger? parent = ()) {
        self.applicationName = applicationName;
        self.version = version;
        self.parent = parent;
        self.currentLevel = log:INFO;
        self.context = context.cloneReadOnly();
    }

    public isolated function printInfo(string|log:PrintableRawTemplate msg, error? 'error = (),
            error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
        if logLevelWeight[self.getLevel()] > logLevelWeight[log:INFO] {
            return;
        }
        string evaluatedMsg = msg is string ? msg : log:evaluateTemplate(msg);
        string printableMsg = string `[Application: ${self.applicationName} v${self.version}] ${evaluatedMsg}`;
        log:KeyValues newKeyValues = {...self.context};
        foreach [string, log:Value] [k, v] in keyValues.entries() {
            newKeyValues[k] = v;
        }
        log:printInfo(printableMsg, 'error, stackTrace, newKeyValues);
    }

    public isolated function printWarn(string|log:PrintableRawTemplate msg, error? 'error = (),
            error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
        // Add similar implementation or a custom logic for warnings
    }

    public isolated function printError(string|log:PrintableRawTemplate msg, error? 'error = (),
            error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
        // Add similar implementation or a custom logic for warnings
    }

    public isolated function printDebug(string|log:PrintableRawTemplate msg, error? 'error = (),
            error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
        // Add similar implementation or a custom logic for warnings
    }

    public isolated function withContext(*log:KeyValues keyValues) returns log:Logger|error {
        log:KeyValues newContext = {...self.context};
        foreach [string, log:Value] [k, v] in keyValues.entries() {
            newContext[k] = v;
        }
        return new ApplicationLogger(self.applicationName, self.version, newContext, self);
    }

    public isolated function getLevel() returns log:Level {
        ApplicationLogger? p = self.parent;
        if p is ApplicationLogger {
            return p.getLevel();
        }
        lock {
            return self.currentLevel;
        }
    }

    public isolated function setLevel(log:Level level) returns error? {
        if self.parent is ApplicationLogger {
            return error("unsupported operation: cannot set level on a child logger");
        }
        lock {
            self.currentLevel = level;
        }
    }
}

public function main() returns error? {
    // Use custom application logger
    ApplicationLogger appLogger = new ("OrderService", "2.1.0");
    appLogger.printInfo("Application logger initialized", feature = "order_processing");

    // Create contextual logger from custom logger
    log:Logger orderLogger = check appLogger.withContext(orderId = "ORDER-12345",
                                                         customerId = "CUST-67890");
    orderLogger.printInfo("Processing order");
    orderLogger.printDebug("Validating order details");

    appLogger.printInfo("Application processing completed");
}
