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
import org.ballerinalang.command.util.ErrorUtil;
import picocli.CommandLine;

import java.io.PrintStream;
import java.util.List;

/**
 * This class represents the "Update" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "dist", description = "Ballerina distribution commands")
public class DistributionCommand extends Command implements BCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> distCommands;

    @CommandLine.Option(names = { "--help", "-h", "?" }, hidden = true, description = "for more information")
    private boolean helpFlag;

    public DistributionCommand(PrintStream printStream) {
        super(printStream);
    }

    private CommandLine parentCmdParser;

    @Override
    public void execute() {
        if (helpFlag || distCommands == null) {
            printUsageInfo(BallerinaCliCommands.DIST);
            return;
        }

        if (distCommands.size() > 1) {
            throw ErrorUtil.createUsageExceptionWithHelp("too many arguments given");
        }

        throw ErrorUtil.createUsageExceptionWithHelp("unknown command '" + distCommands.get(0) + "'");
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.DIST;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }

}
