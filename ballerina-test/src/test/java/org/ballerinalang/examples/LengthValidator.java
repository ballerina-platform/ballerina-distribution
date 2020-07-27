package LengthValidation;

import java.io.*;
import java.util.NoSuchElementException;

public class LengthValidator {

    private static int LINE_MAX_LIMIT = 80;
    private static  boolean isDebugEnabled = false;
    private static String[] fileFilterExtensions;
    private static String defaultFilerExtension = ".txt";

    public static void logger(String message) {
        if (isDebugEnabled) {
            System.out.println(message);
        }
    }

    public static void validateLineLength(String path, String fileName) throws LineLengthExceededException, NoSuchElementException {
        BufferedReader reader;
        try {
            reader = new BufferedReader(new FileReader(path));
            String line;

            int lineCount = 1;
            do {
                line = reader.readLine();
                if (line != null) {
                    int count = line.length();
                    if(count > LINE_MAX_LIMIT){
                        throw new LineLengthExceededException(String.format("[%s] Line length is exceeded in line number %d. Maximum length is %s for a single line.", path, lineCount, LINE_MAX_LIMIT));
                    }
                }
                lineCount += 1;
            } while (line != null);

            reader.close();
            logger(String.format("[%s] All lines in this file contain less than %s characters", fileName, LINE_MAX_LIMIT));

        } catch (IOException e) {
            logger(String.format("[%s] An IOException occurred for file name : %s", fileName, path));
            throw new NoSuchElementException("An error occurred during IO operation");
        } catch(NoSuchElementException e) {
            logger(String.format("Invalid file name given : %s",  path));
            throw new NoSuchElementException("Invalid file name");
        }

    }

    public static void validateFileExtension(File fileEntry, String[] extensions) throws LineLengthExceededException {
        for(String extension: extensions) {
            if(fileEntry.getName().endsWith(extension)) {
                LengthValidator.validateLineLength(fileEntry.getPath(), fileEntry.getName());
            }
        }
    }

    public static  void listFilesForFolder(final File folder) throws LineLengthExceededException {
        for (final File fileEntry : folder.listFiles()) {
            if (fileEntry.isDirectory()) {
                listFilesForFolder(fileEntry);
            } else {
                validateFileExtension(fileEntry, fileFilterExtensions);
            }
        }
    }

    public static void main(String[] args) throws LineLengthExceededException {
        String filePath = "";
        try {
            if(args.length > 0) {
                filePath = args[0];
            }
            if(args.length > 1) {
                isDebugEnabled = Boolean.valueOf(args[1]);
            }

            if(args.length > 2) {
                if (!args[2].isEmpty()) {
                    String[] splittedArg = args[2].split(",");
                    fileFilterExtensions = new String[splittedArg.length];
                    int counter = 0;
                    for(String extension: splittedArg) {
                        fileFilterExtensions[counter] = extension.trim();
                        counter += 1;
                    }
                } else {
                    fileFilterExtensions = new String[] { defaultFilerExtension };
                }
            } else {
                fileFilterExtensions = new String[] { defaultFilerExtension };
            }

            logger(String.format("Started line length validations in directory : %s",  filePath));
            LengthValidator.listFilesForFolder(new File(filePath));
        } catch(Exception e){
            logger(e.getMessage());
            throw e;
        }
    }
}
