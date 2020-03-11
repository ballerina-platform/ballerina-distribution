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

public class CentOS implements Executor {
    private String packageName;
    private String installerName;
    private String version;

    public CentOS(String version) {
        this.version = version;
        installerName = "ballerina-linux-installer-x64-" + version + ".rpm";
        packageName = "ballerina-" + version;
    }

    @Override
    public String transferArtifacts() {
        Utils.downloadFile(version, installerName);
        String command = "cp " + installerName + " ~";
        return Utils.executeCommand(command);
    }

    @Override
    public String install() {
        String command = "sudo rpm -i ~/" + installerName;
        return Utils.executeCommand(command);
    }

    @Override
    public String executeCommand(String command, boolean isAdminMode) {
        String sudoCommand = isAdminMode ? "sudo " : "";
        String shellCommand = sudoCommand + command;
        return Utils.executeCommand(shellCommand);
    }

    @Override
    public String uninstall() {
        String command = "sudo rpm -e " + packageName;
        return Utils.executeCommand(command);
    }

    @Override
    public String cleanArtifacts() {
        String command = "rm ~/" + installerName + " && rm -rf ~/.ballerina";
        return Utils.executeCommand(command);
    }
}
