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
import org.ballerinalang.update.util.Distribution;
import org.ballerinalang.update.util.ToolUtil;
import org.ballerinalang.update.util.Version;
import picocli.CommandLine;

import java.io.IOException;
import java.io.PrintStream;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

/**
 * This class represents the "Update" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "update", description = "Update Ballerina current distribution")
public class UpdateCommand extends Command implements BLauncherCommand {

    @CommandLine.Parameters(description = "Command name")
    private List<String> updateCommands;

    @CommandLine.Option(names = {"--help", "-h", "?"}, hidden = true)
    private boolean helpFlag;

    private CommandLine parentCmdParser;

    public UpdateCommand(PrintStream printStream) {
        super(printStream);
    }

    public void execute() {
        if (helpFlag) {
            printUsageInfo(BallerinaCliCommands.UPDATE);
            return;
        }

        if (updateCommands == null) {
            update(getPrintStream());
            return;
        } else if (updateCommands.size() > 1) {
            //     throw LauncherUtils.createUsageExceptionWithHelp("too many arguments given");
        }

        String userCommand = updateCommands.get(0);
        if (parentCmdParser.getSubcommands().get(userCommand) == null) {
            //     throw LauncherUtils.createUsageExceptionWithHelp("unknown command " + userCommand);
        }
    }

    @Override
    public String getName() {
        return BallerinaCliCommands.UPDATE;
    }

    @Override
    public void printLongDesc(StringBuilder out) {

    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("  ballerina dist update\n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }

    public static void update(PrintStream printStream) {
        try {
            String version = ToolUtil.getCurrentBallerinaVersion();
            List<String> versions = new ArrayList<>();
            for (Distribution distribution : ToolUtil.getDistributions()) {
                versions.add(distribution.getVersion());
            }
            Version currentVersion = new Version(version);
            String latestVersion = currentVersion.getLatest(versions.stream().toArray(String[]::new));
            if (!latestVersion.equals(version)) {
                String distribution = ToolUtil.BALLERINA_TYPE + "-" + latestVersion;
                ToolUtil.downloadDistribution(printStream, distribution, false);
                ToolUtil.use(printStream, distribution);
            } else {
                printStream.println("No update found");
            }
        } catch (IOException | KeyManagementException | NoSuchAlgorithmException e) {
            printStream.println("Cannot connect to the central server");
        }
    }
}
