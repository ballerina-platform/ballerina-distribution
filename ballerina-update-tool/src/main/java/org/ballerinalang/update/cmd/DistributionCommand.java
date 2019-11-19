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
 * This class represents the "Update" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "dist", description = "Ballerina distribution commands")
public class DistributionCommand extends Command implements BLauncherCommand {

    @CommandLine.Option(names = { "--help", "-h", "?" }, hidden = true, description = "for more information")
    private boolean helpFlag;

    public DistributionCommand(PrintStream printStream) {
        super(printStream);
    }

    @Override
    public void execute() {
        if (helpFlag) {
            printUsageInfo(BallerinaCliCommands.HELP);
            return;
        }

        printUsageInfo(BallerinaCliCommands.DIST);
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
    }
}
