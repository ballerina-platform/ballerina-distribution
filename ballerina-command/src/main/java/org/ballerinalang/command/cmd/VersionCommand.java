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

package org.ballerinalang.command.cmd;

import org.ballerinalang.command.BallerinaCliCommands;
import picocli.CommandLine;

import java.io.PrintStream;
import java.util.List;

/**
 * This class represents the "version" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "version", description = "Prints Ballerina version")
public class VersionCommand extends Command implements BCommand {
    @CommandLine.Parameters(description = "Command name")
    private List<String> versionCommands;

    @CommandLine.Option(names = {"--help", "-h", "?"}, hidden = true)
    private boolean helpFlag;

    private CommandLine parentCmdParser;

    public VersionCommand(PrintStream printStream) {
        super(printStream);
    }

    public void execute() {
        if (helpFlag) {
            printUsageInfo(BallerinaCliCommands.VERSION);
            return;
        }

        if (versionCommands == null) {
            printVersionInfo();
            return;
        } else if (versionCommands.size() > 1) {
            createUsageExceptionWithHelp("too many arguments given");
        }

        String userCommand = versionCommands.get(0);
        if (parentCmdParser.getSubcommands().get(userCommand) == null) {
            throw createUsageExceptionWithHelp("unknown command " + userCommand);
        }
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.VERSION;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("  ballerina version \n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }
}
