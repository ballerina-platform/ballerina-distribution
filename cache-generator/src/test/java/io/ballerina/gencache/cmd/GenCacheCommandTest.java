package io.ballerina.gencache.cmd;

import org.testng.annotations.Test;
import picocli.CommandLine;

@Test
public class GenCacheCommandTest {
    public void getExecuteCommand(String orgName, String moduleName, String version) {
        String[] args = {"--org", orgName, "--module", moduleName, "--version", version};
        GenCacheCmd cmd = new GenCacheCmd();
        new CommandLine(cmd).parseArgs(args);

        try{
            cmd.execute();
        }catch (Exception e){
            System.out.println("exception occurred in cache generation "+ e);
        }catch (Error e){
            System.out.println("error occurred in cache generation "+ e);
        }
    }
}