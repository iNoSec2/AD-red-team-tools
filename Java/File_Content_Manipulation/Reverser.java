import java.util.Scanner;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * A program that takes a file from user and reverses its contents to a new file.
 *
 * @author     Astillo, Lyle
 */
 
public class Reverser {

   public static void main(String[] args) {
      
      Scanner userIn = new Scanner(System.in); // Creating Scanner object.
      String inFile; // Holds the name of file.
      String outFile; // Holds the name of output file. 
      String repeat; // Holds user responese in order to repeat task or nah.
      boolean done = false; // Determines whether or not to repeat task based on repeat.
   
      do {
         System.out.print("Please enter the file name containing song lyrics that you want reveresed:");
         inFile = userIn.nextLine(); // Prompts user to enter name of file.
         System.out.print("Enter an output file name:");
         outFile = userIn.nextLine(); // Prompts user to enter name of the new file.
      
         if (inFile.equals("")) {
            System.out.print("or nah. K. Bye!"); 
            done = true; // If user does not enter anything = end.
         }
         else {   
            contentProcessor(inFile, outFile); // Pass file name and new file name to contentProcessor().
            System.out.print("Done? Type (Y)es or (N)o:");
            repeat = userIn.nextLine();        
            if (repeat.equals("") || repeat.equalsIgnoreCase("Yes") || repeat.charAt(0) == 'Y' || repeat.charAt(0) == 'y') {
               System.out.print("K. Bye!");
               done = true; // Asks user if done, if no answer or (Yes, Y, y) = end.           
            }
            else if (repeat.equalsIgnoreCase("No") || repeat.charAt(0) == 'N' || repeat.charAt(0) == 'n') {
               done = false; // If answer = No, N, n = repeat.
            }
            else {
               System.out.print("\nIt's a Yes or No question.\n");
               System.exit(0); // If user cant follow directions = end.
            }
         }                       
      } while (done == false);
   }
   
   /**
    * A method that is used to take a file and write its contents in reverse to a new file.
    *
    * @param         inFile         Used to take a string/file to be processed.
    * @param         outFile        Used to take a string to name the output file.
    * @exceptions    IoException e  If file does not exist = tell user.   
    */   
   public static void contentProcessor(String inFile, String outFile) {
   
      File inputFile = new File(inFile); // Creating a file handler.
      String outputFile = outFile; // Creating output file name based on user input.
      String lines = ""; // Holds contents of input files.
      String delimeter = "\n"; // Used for formating contents of input and output files.
      String[] lyrics;
      try {
         Scanner fileReader = new Scanner(inputFile); // Creating Scanner object to read input file.        
         if (inputFile.length() != 0) {         
            FileWriter writer = new FileWriter(outputFile, false); 
            while (fileReader.hasNextLine()) {                     // Check if input file contains anything.
               lines += fileReader.nextLine() + delimeter;         // if it does, add contents to lines and create FileWriter object.
            }
            lyrics = lines.split(delimeter); // Put copy of lines contents into lyrics[].
            for (int i = lyrics.length - 1; i >= 0; i--) { 
               writer.write(lyrics[i] + delimeter); // Outputs contents of lyrics[] in reverse order to output file.
            }
            writer.close(); // Close writer and tell user process is done.
            System.out.printf("%n%s%s%s%n%n", "Reversed lyrics will be in ", outputFile, " in the current directory.");
         }  
         else {
            System.out.println("\nThere was nothing inside the file!"); // If file is empty, tell user.
         }
      }
      catch (IOException e) { // Catches all File I/O related excpetions e.g., file not found.
         System.out.println("\nPlease check input file\n");
      }
   }
}