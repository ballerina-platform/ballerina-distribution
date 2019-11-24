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

import java.util.List;

/**
 * This class represents the "help" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "help", description = "print usage information")
public class HelpCommand extends Command implements BLauncherCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> helpCommands;

    private CommandLine parentCmdParser;

    public void execute() {
        if (helpCommands == null) {
            printUsageInfo(BallerinaCliCommands.HELP);
            return;

        } else if (helpCommands.size() > 2) {
            //TODO: fix later
//            throw createUsageExceptionWithHelp("too many arguments given");
              return;
        }

        int index = helpCommands.size() == 2 ? 1 : 0;
        String userCommand = helpCommands.get(index);
        if (helpCommands.get(index) == null) {
            //TODO: fix later
//            throw createUsageExceptionWithHelp("unknown help topic `" + userCommand + "`");
                return;
        }

        String commandUsageInfo = getCommandUsageInfo(userCommand);
        getPrintStream().println(commandUsageInfo);
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.HELP;
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
