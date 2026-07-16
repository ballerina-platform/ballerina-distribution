/*
 *  Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package io.ballerina.gencache.cmd;

import io.ballerina.cli.BLauncherCmd;
import io.ballerina.projects.*;
import io.ballerina.projects.bala.BalaProject;
import io.ballerina.projects.repos.FileSystemCache;
import io.ballerina.tools.diagnostics.Diagnostic;
import picocli.CommandLine;

import java.io.PrintStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@CommandLine.Command(
        name = "gencache",
        description = "Generates the Ballerina standard library caches"
)

public class GenCacheCmd implements BLauncherCmd{
    private static final String CMD_NAME = "gencache";
    private PrintStream outStream;
    private PrintStream errStream;
    private boolean exitWhenFinish;
    private static final String BALLERINA_HOME_KEY = "ballerina.home";
    private String balaPath;
    private String workingDir;

     @CommandLine.Parameters
     private List<String> argList;

    public GenCacheCmd() {
        this.outStream = System.out;
        this.errStream = System.err;
        this.exitWhenFinish = true;
    }

    @Override
    public void execute() {
        balaPath = argList.get(0);
        workingDir = argList.get(1);

        if ( balaPath == null || workingDir == null ) {
            errStream.println("missing input options");
            exitError(this.exitWhenFinish);
            return;
        }

        try {
            outStream.println(workingDir);
            outStream.println(balaPath);
            Path jBalToolsPath = Paths.get( workingDir);
            Path repo = jBalToolsPath.resolve( "repo");
            Path modulePath = Paths.get(balaPath);
            System.setProperty(BALLERINA_HOME_KEY, repo.getParent().toString());
            ProjectEnvironmentBuilder defaultBuilder = ProjectEnvironmentBuilder.getDefaultBuilder();
            defaultBuilder.addCompilationCacheFactory(new FileSystemCache.FileSystemCacheFactory(repo.resolve("cache")));
            Project balaProject = BalaProject.loadProject(defaultBuilder, modulePath);
            PackageCompilation packageCompilation = balaProject.currentPackage().getCompilation();
            DiagnosticResult diagnosticResult = packageCompilation.diagnosticResult();
            for (Diagnostic diagnostic : diagnosticResult.diagnostics()) {
                outStream.println(diagnostic.toString());
            }
            if (diagnosticResult.hasErrors()) {
                return;
            }
            JBallerinaBackend jBallerinaBackend = JBallerinaBackend.from(packageCompilation, JvmTarget.JAVA_21);
            diagnosticResult = jBallerinaBackend.diagnosticResult();
            for (Diagnostic diagnostic : diagnosticResult.diagnostics()) {
                outStream.println(diagnostic.toString());
            }
            //TODO : Remove when regeneration is not required
        } catch (Error e) {
            //TODO : Ignore Error and continue generation as regeneration will be done
            outStream.println("Error occurred " + balaPath + " " + e);
        } catch (Exception e) {
            //TODO : Ignore Exception and continue generation as regeneration will be done
            outStream.println("Exception occurred " + balaPath + " " + e);
        }
    }

    @Override
    public String getName() {
        return CMD_NAME;
    }

    @Override
    public void printLongDesc(StringBuilder out) {
        out.append("Build a Ballerina project and produce an executable JAR file. The \n");
        out.append("executable \".jar\" file will be created in the <PROJECT-ROOT>/target/bin directory. \n");
        out.append("\n");
        out.append("Build a single Ballerina file. This creates an executable .jar file in the \n");
        out.append("current directory. The name of the executable file will be \n");
        out.append("<ballerina-file-name>.jar. \n");
        out.append("\n");
    }

    @Override
    public void printUsage( StringBuilder out ) {
        out.append("  bal gencache [bala-path] [package-path] ");
    }

    @Override
    public void setParentCmdParser( CommandLine parentCmdParser) {
    }

    private void exitError(boolean exitWhenFinish) {
        if ( exitWhenFinish ) {
            Runtime.getRuntime().exit(1);
        }
    }

}
