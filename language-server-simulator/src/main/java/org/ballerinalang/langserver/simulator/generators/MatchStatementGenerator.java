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
package org.ballerinalang.langserver.simulator.generators;

import org.ballerinalang.annotation.JavaSPIService;

/**
 * Match statement code snippet generator.
 *
 * @since 2201.8.0
 */
@JavaSPIService("org.ballerinalang.langserver.org.ballerinalang.langserver.simulator.generators.CodeSnippetGenerator")
public class MatchStatementGenerator extends CodeSnippetGenerator {

    /**
     * Generates a match statement.
     *
     * @return Match statement
     */
    @Override
    public String generate() {
        // This statement has intentionally added syntax errors.
        return "\nmatch t {\n" +
                "    () => {\n}" +
                "    [1, 2] => {\n}" +
                "    [1, 2, 10] => {\n}" +
                "    [int => {\n" +
                "    _ => {\n}" +
                "}\n";
    }

    @Override
    public Generators.Type type() {
        return Generators.Type.MATCH_STATEMENT;
    }
}
