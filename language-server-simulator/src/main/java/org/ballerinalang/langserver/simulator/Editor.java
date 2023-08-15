/*
 * Copyright (c) 2023, WSO2 LLC. (http://wso2.com) All Rights Reserved.
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
package org.ballerinalang.langserver.simulator;

import org.ballerinalang.langserver.BallerinaLanguageServer;
import org.ballerinalang.langserver.commons.command.CommandArgument;
import org.ballerinalang.langserver.util.TestUtil;
import org.eclipse.lsp4j.ExecuteCommandParams;
import org.eclipse.lsp4j.jsonrpc.Endpoint;

import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Represents the editor used by the end user, which editor consists of a set of open tabs.
 *
 * @since 2201.8.0
 */
public class Editor {

    private final BallerinaLanguageServer languageServer;
    private final Endpoint endpoint;

    private final List<EditorTab> tabs = new ArrayList<>();
    private EditorTab activeTab;

    private boolean isPulled = false;

    private Editor(BallerinaLanguageServer languageServer, Endpoint endpoint) {
        this.languageServer = languageServer;
        this.endpoint = endpoint;
    }

    /**
     * Simulates opening the editor. Here we initialize the language server.
     *
     * @return Editor instance
     */
    public static Editor open() {
        BallerinaLanguageServer languageServer = new BallerinaLanguageServer();

        EditorOutputStream outputStream = new EditorOutputStream();
        Endpoint endpoint = TestUtil.initializeLanguageSever(languageServer, outputStream);
        Editor editor = new Editor(languageServer, endpoint);
        outputStream.setEditor(editor);
        return editor;
    }

    public EditorTab openFile(Path filePath) {
        //Pull missing modules from central
        if (!isPulled) {
            CommandArgument uriArg = CommandArgument.from("doc.uri", filePath);
            List<Object> args = new ArrayList<>();
            args.add(uriArg);
            ExecuteCommandParams params = new ExecuteCommandParams("PULL_MODULE", args);
            TestUtil.getExecuteCommandResponse(params, endpoint);
            isPulled = true;
        }

        EditorTab editorTab = tabs.stream()
                .filter(tab -> tab.filePath().equals(filePath))
                .findFirst()
                .orElseGet(() -> {
                    EditorTab tab = new EditorTab(filePath, endpoint, languageServer);
                    tabs.add(tab);
                    return tab;
                });
        this.activeTab = editorTab;
        return editorTab;
    }

    public void closeFile(Path filePath) {
        Iterator<EditorTab> iterator = tabs.iterator();
        while (iterator.hasNext()) {
            EditorTab tab = iterator.next();
            if (filePath.equals(tab.filePath())) {
                if (activeTab != null && activeTab.equals(tab)) {
                    activeTab = null;
                }
                iterator.remove();
            }
        }
    }

    public void closeTab(EditorTab tab) {
        tabs.remove(tab);
        if (activeTab != null && activeTab.equals(tab)) {
            activeTab = null;
        }
    }

    public void close() {
        this.languageServer.shutdown();
        tabs.forEach(EditorTab::close);
    }

    public EditorTab activeTab() {
        return activeTab;
    }
}
