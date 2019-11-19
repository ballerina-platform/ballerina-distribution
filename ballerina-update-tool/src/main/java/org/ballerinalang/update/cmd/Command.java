/*
 * Copyright (c) 2019, WSO2 Inc. (http://wso2.com) All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.ballerinalang.update.cmd;


import org.ballerinalang.update.BLauncherCommand;

import java.io.PrintStream;

/**
 * Command class with generic methods.
 */
public abstract class Command {
    private PrintStream printStream;

    public Command() {
        this.printStream = System.out;
    }

    public Command(PrintStream printStream) {
        this.printStream = printStream;
    }

    public PrintStream getPrintStream() {
        return printStream;
    }

    public void setPrintStream(PrintStream printStream) {
        this.printStream = printStream;
    }

    public void printUsageInfo(String commandName) {
        String usageInfo = BLauncherCommand.getCommandUsageInfo(commandName);
        getPrintStream().println(usageInfo);
    }
}
