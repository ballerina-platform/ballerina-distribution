/*
 *  Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import org.junit.Test;
import picocli.CommandLine;

import java.io.PrintStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;

@CommandLine.Command(
        name = "gencache",
        description = "Generates the Ballerina standard library caches"
)

public class GenCacheCmd implements BLauncherCmd{
    private static final String CMD_NAME = "gencache";
    private final Path repo;
    private PrintStream outStream;
    private Path executionPath = Paths.get(System.getProperty("user.dir"));
    private Path targetOutputPath;
    private boolean exitWhenFinish;

    @CommandLine.Option(names = {"-o", "--org"}, description = "organization name")
    private String orgName;

    @CommandLine.Option(names = {"-m", "--module"}, description = "module name")
    private String moduleName;

    @CommandLine.Option(names = {"-v", "--version"}, description = "module version")
    private String version;

    Path balaPath = Paths.get("build/target/extracted-distribution/"+moduleName+"-ballerina-zip/bala/"+orgName+"/"+moduleName+"/"+version+"/java11");

//    @CommandLine.Parameters
//    private List<Path> balaList= Collections.singletonList(Paths.get("build/target/extracted-distributions/http-ballerina-zip/bala/ballerina/http/1.1.0-beta.2/java11"));
//    repo.resolve("cache").resolve(orgName).resolve(moduleName).resolve(version).resolve("java11")

    public GenCacheCmd() {
        String args = "build/target/extracted-distributions/jballerina-tools-zip/jballerina-tools-${ballerinaLangVersion}";
        Path jBalToolsPath = Paths.get(args);
        this.repo = jBalToolsPath.resolve("repo");
    }

    //                //Standard Libraries
//                "ballerina-io",
//                "ballerinax-java.arrays",
//                "ballerina-random",
//                "ballerina-regex",
//                "ballerina-runtime",
//                "ballerina-task",
//                "ballerina-time",
//                "ballerina-url",
//                "ballerina-xmldata",
//                "ballerina-cache",
//                "ballerina-crypto",
//                "ballerina-os",
//                "ballerina-xslt",
//                "ballerina-log",
//                "ballerina-reflect",
//                "ballerina-uuid",
//                "ballerina-auth",
//                "ballerina-file",
//                "ballerina-ftp",
//                "ballerina-jwt",
//                "ballerina-mime",
//                "ballerina-nats",
//                "ballerina-oauth2",
//                "ballerina-stan",
//                "ballerina-tcp",
//                "ballerina-udp",
//                "ballerina-email",
//                "ballerina-http",
//                "ballerina-grpc",
//                "ballerinai-transaction",
//                "ballerina-websocket",
//                "ballerina-websub",
//                "ballerina-websubhub",
//                "ballerina-kafka",
//                "ballerina-rabbitmq",
//                "ballerina-sql",
//                "ballerinax-java.jdbc",
//                "ballerinax-mysql",
//                "ballerina-graphql",
//                "ballerina-graphql", // TODO : graphql had to generate twice
//                //Extensions
//                //TODO: Revisit extensions
//                "ballerina-openapi",
//                "ballerina-docker",
//                "ballerinax-awslambda",
//                "ballerinax-azure_functions",
//                "ballerinax-choreo",
//                "ballerinax-jaeger",
//                "ballerinax-prometheus",
//                "ballerinai-observe"
//        };
    @Override
    public void execute() {

        if (orgName == null || moduleName == null || version== null) {
            outStream.println("missing input options");
            exitError(this.exitWhenFinish);
            return;
        }

        try {
            System.setProperty(BALLERINA_HOME_KEY, repo.getParent().toString());
            ProjectEnvironmentBuilder defaultBuilder = ProjectEnvironmentBuilder.getDefaultBuilder();
            defaultBuilder.addCompilationCacheFactory(new FileSystemCache.FileSystemCacheFactory(repo.resolve("cache")));
            Project balaProject = BalaProject.loadProject(defaultBuilder, balaPath);
            PackageCompilation packageCompilation = balaProject.currentPackage().getCompilation();
            JBallerinaBackend.from(packageCompilation, JvmTarget.JAVA_11);
            //TODO : Remove when regeneration is not required
        } catch (Error e) {
            //TODO : Ignore Error and continue generation as regeneration will be done
            System.out.println("Error occurred " + moduleName + " " + e);
        } catch (Exception e) {
            //TODO : Ignore Exception and continue generation as regeneration will be done
            System.out.println("Exception occurred " + moduleName + " " + e);
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
        out.append("If the output file is specified with the -o flag, the output \n");
        out.append("will be written to the given output file name. The -o flag will only \n");
        out.append("work for single files. \n");
    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("  bal build [-o <output>] [--offline] [--skip-tests]\\n\" +\n" +
                "            \"                    [<ballerina-file | package-path>]");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
    }

    private void exitError(boolean exitWhenFinish) {
        if (exitWhenFinish) {
            Runtime.getRuntime().exit(1);
        }
    }

}