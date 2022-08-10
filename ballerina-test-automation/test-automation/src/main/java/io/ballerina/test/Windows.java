/*
 * Copyright (c) 2020, WSO2 Inc. (http://wso2.com) All Rights Reserved.
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

package io.ballerina.test;

public class Windows implements Executor {
    private String installerName;
    private String version;

    public Windows(String version) {
        this.version = version;
        installerName = "ballerina-windows-x64-" + version + ".msi";
    }

    @Override
    public String transferArtifacts() {
        Utils.downloadFile(version, installerName);
        return "";
    }

    @Override
    public String install() {
        return Utils.executeCommand("msiexec /i " + Utils.getUserHome() + "\\" + installerName
                + " /qn /l \"install-log.log\"");
    }

    @Override
    public String executeCommand(String command, boolean isAdminMode, String toolVersion) {
        return Utils.executeCommand(Utils.getCommandName(toolVersion) + command);
    }

    @Override
    public String uninstall() {
        return Utils.executeCommand("wmic product where name=\"Ballerina " + version + "\" call uninstall/nointeractive");
    }

    @Override
    public String cleanArtifacts() {
        return Utils.executeCommand("rmdir /Q /S " + Utils.getUserHome() + "\\.ballerina");
    }
}
