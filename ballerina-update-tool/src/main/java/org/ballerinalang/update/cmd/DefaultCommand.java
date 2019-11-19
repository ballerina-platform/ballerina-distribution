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
import org.ballerinalang.update.BallerinaCliCommands;
import picocli.CommandLine;

import java.io.PrintStream;

/**
 * This class represents the "default" command required by picocli.
 */
@CommandLine.Command(description = "Default Command.", name = "default")
public class DefaultCommand extends Command implements BLauncherCommand {

    @CommandLine.Option(names = { "--help", "-h", "?" }, hidden = true, description = "for more information")
    private boolean helpFlag;

    // --debug flag is handled by ballerina.sh/ballerina.bat. It will launch ballerina with java debug options.
    @CommandLine.Option(names = "--debug", description = "start Ballerina in remote debugging mode")
    private String debugPort;

    public DefaultCommand(PrintStream printStream) {
        super(printStream);
    }

    @Override
    public void execute() {
        printUsageInfo(BallerinaCliCommands.HELP);
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.DEFAULT;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
    }
}
