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

package org.ballerinalang.update;

import org.ballerinalang.update.cmd.DefaultCommand;
import org.ballerinalang.update.cmd.DistributionCommand;
import org.ballerinalang.update.cmd.FetchCommand;
import org.ballerinalang.update.cmd.HelpCommand;
import org.ballerinalang.update.cmd.ListCommand;
import org.ballerinalang.update.cmd.PullCommand;
import org.ballerinalang.update.cmd.RemoveCommand;
import org.ballerinalang.update.cmd.UpdateCommand;
import org.ballerinalang.update.cmd.UseCommand;
import picocli.CommandLine;

import java.io.PrintStream;
import java.util.List;
import java.util.Optional;

/**
 * This class executes a Ballerina program.
 */
public class Main {

    private static PrintStream errStream = System.err;
    private static PrintStream outStream = System.out;


    public static void main(String... args) {
        try {
            Optional<BLauncherCommand> optionalInvokedCmd = getInvokedCmd(args);
            optionalInvokedCmd.ifPresent(BLauncherCommand::execute);
        } catch (Exception e) {
            Runtime.getRuntime().exit(1);
        } catch (Throwable e) {
            Runtime.getRuntime().exit(1);
        }
    }

    private static Optional<BLauncherCommand> getInvokedCmd(String... args) {
//        try {
            DefaultCommand defaultCmd = new DefaultCommand(outStream);
            CommandLine cmdParser = new CommandLine(defaultCmd);
            defaultCmd.setParentCmdParser(cmdParser);

            HelpCommand helpCommand = new HelpCommand();
            cmdParser.addSubcommand(BallerinaCliCommands.HELP, helpCommand);
            helpCommand.setParentCmdParser(cmdParser);

            //DistCommand Command
            DistributionCommand distCmd = new DistributionCommand(outStream);
            CommandLine distCmdParser = new CommandLine(distCmd);
            distCmd.setParentCmdParser(distCmdParser);

            ListCommand listCmd = new ListCommand(outStream);
            distCmdParser.addSubcommand(BallerinaCliCommands.LIST, listCmd);
            listCmd.setParentCmdParser(distCmdParser);

            PullCommand pullCmd = new PullCommand(outStream);
            distCmdParser.addSubcommand(BallerinaCliCommands.PULL, pullCmd);
            pullCmd.setParentCmdParser(distCmdParser);

            FetchCommand fetchCmd = new FetchCommand(outStream);
            distCmdParser.addSubcommand(BallerinaCliCommands.FETCH, fetchCmd);
            fetchCmd.setParentCmdParser(distCmdParser);

            RemoveCommand removeCmd = new RemoveCommand(outStream);
            distCmdParser.addSubcommand(BallerinaCliCommands.REMOVE, removeCmd);
            removeCmd.setParentCmdParser(distCmdParser);

            UpdateCommand updateCmd = new UpdateCommand(outStream);
            distCmdParser.addSubcommand(BallerinaCliCommands.UPDATE, updateCmd);
            updateCmd.setParentCmdParser(distCmdParser);

            UseCommand useCmd = new UseCommand(outStream);
            distCmdParser.addSubcommand(BallerinaCliCommands.USE, useCmd);
            useCmd.setParentCmdParser(distCmdParser);

            distCmdParser.setCommandName("dist");
            distCmdParser.setPosixClusteredShortOptionsAllowed(false);

            cmdParser.addSubcommand(BallerinaCliCommands.DIST, distCmdParser);

            cmdParser.setCommandName("ballerina");
            cmdParser.setPosixClusteredShortOptionsAllowed(false);


            List<CommandLine> parsedCommands = cmdParser.parse(args);

            if (parsedCommands.size() < 1) {
                return Optional.of(defaultCmd);
            }

            return Optional.of(parsedCommands.get(parsedCommands.size() - 1).getCommand());
//        } catch (CommandLine.UnmatchedArgumentException e) {
//            return  null;
//        } catch (CommandLine.ParameterException e) {
//            return null;
//        }
    }

//    private static void printUsageInfo(String commandName) {
//        String usageInfo = BLauncherCommand.getCommandUsageInfo(commandName);
//        errStream.println(usageInfo);
//    }
}
