package disttest.cli;

import io.ballerina.cli.BLauncherCmd;
import picocli.CommandLine;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

@CommandLine.Command(name = "disttest", description = "The tool implementation for ballerina distribution tool tests")
public class DistTestCommand implements BLauncherCmd {
    private final PrintStream printStream;

    @CommandLine.Option(names = {"--help", "-h", "?"}, usageHelp = true)
    private boolean helpFlag;

    @CommandLine.Parameters(description = "User name")
    private List<String> argList;

    public DistTestCommand() {
        this.printStream = System.out;
    }

    public DistTestCommand(PrintStream printStream) {
        this.printStream = printStream;
    }

    @Override
    public void execute() {
        if (helpFlag) {
            StringBuilder out = new StringBuilder();
            appendHelpText(out);
            printStream.println(out);
            return;
        }
        if (argList == null || argList.size() < 1) {
            printStream.println("dist test command 1.0.0 is executing with no args\n");
            return;
        }
        printStream.println("dist test command 1.0.0 is executing with args " + argList.get(0) + "\n");
    }

    @Override
    public String getName() {
        return "disttest";
    }

    @Override
    public void printLongDesc(StringBuilder out) {
        appendHelpText(out);
    }

    @Override
    public void printUsage(StringBuilder out) {
        out.append("A sample tool built for testing bal tool functionality");
    }

    @Override
    public void setParentCmdParser(CommandLine parentCmdParser) {
    }

    private void appendHelpText(StringBuilder out) {
        Class<?> clazz = DistTestCommand.class;
        ClassLoader classLoader = clazz.getClassLoader();
        InputStream inputStream = classLoader.getResourceAsStream("disttest.help");
        if (inputStream != null) {
            try (InputStreamReader inputStreamREader = new InputStreamReader(inputStream, StandardCharsets.UTF_8);
                 BufferedReader br = new BufferedReader(inputStreamREader)) {
                String content = br.readLine();
                out.append(content);
                while ((content = br.readLine()) != null) {
                    out.append('\n').append(content);
                }
            } catch (IOException e) {
                out.append("Helper text is not available.");
            }
        }
    }
}
