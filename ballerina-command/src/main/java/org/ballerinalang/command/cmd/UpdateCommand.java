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
import org.ballerinalang.command.util.ToolUtil;
import picocli.CommandLine;

import java.io.PrintStream;
import java.util.List;

/**
 * This class represents the "Update" command and it holds arguments and flags specified by the user.
 */
@CommandLine.Command(name = "command", description = "Update Ballerina current distribution")
public class UpdateCommand extends Command implements BCommand {

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
            printUsageInfo("dist-" + BallerinaCliCommands.UPDATE);
            return;
        }

        if (updateCommands == null) {
            ToolUtil.handleInstallDirPermission();
            update(getPrintStream());
            return;
        }

        if (updateCommands.size() > 0) {
            throw ErrorUtil.createUsageExceptionWithHelp("too many arguments given");
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
        out.append("  ballerina dist command\n");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
        this.parentCmdParser = parentCmdParser;
    }

    public static void update(PrintStream printStream) {
        String version = ToolUtil.getCurrentBallerinaVersion();
        printStream.println("Fetching latest distribution version from remote server...");
        String latestVersion = ToolUtil.getLatest(version, "patch");
        if (latestVersion == null) {
            printStream.println("Cannot find the latest patch version for distribution version: " + version);
            return;
        }
        if (!latestVersion.equals(version)) {
            String distribution = ToolUtil.BALLERINA_TYPE + "-" + latestVersion;
            ToolUtil.downloadDistribution(printStream, distribution, ToolUtil.BALLERINA_TYPE, latestVersion);
            ToolUtil.useBallerinaVersion(printStream, distribution);
            printStream.println("Updated to latest distribution version: " + latestVersion);
            return;
        }
        printStream.println("Already in latest distribution version: " + latestVersion);
    }
}
