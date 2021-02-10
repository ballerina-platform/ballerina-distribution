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


public class MacOS implements Executor {
    private String installerName;
    private String version;

    public MacOS(String version) {
        this.version = version;
        this.installerName = "ballerina-macos-installer-x64-" + version + ".pkg";
    }


    @Override
    public String transferArtifacts() {
        Utils.downloadFile(version, installerName);
        return Utils.executeCommand("cp " + installerName + " ~");
    }

    @Override
    public String install() {
        return Utils.executeCommand("sudo installer -pkg " + installerName + " -target /");
    }

    @Override
    public String executeCommand(String command, boolean isAdminMode) {
        String sudoCommand = isAdminMode ? "sudo " : "";
        return Utils.executeCommand(sudoCommand + command);
    }

    @Override
    public String uninstall() {
        return Utils.executeCommand("sudo rm -rf /Library/Ballerina/");
    }

    @Override
    public String cleanArtifacts() {
        return Utils.executeCommand("rm ~/" + installerName + " && sudo rm -rf ~/.ballerina");
    }
}
