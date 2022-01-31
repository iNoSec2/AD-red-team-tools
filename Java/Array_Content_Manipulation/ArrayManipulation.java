import java.util.Scanner;
import java.util.InputMismatchException;

/**
 * A program that creates a double and char array with a length of 60 then fills the double
 * array with numbers ranging from 75.0 - 100.0 using a random number generator. Once the double array has been populated with numbers,
 * the char array will then be filled with As, Bs, and Cs based on the values within the double array,
 * e.g., index 0 in the double array has a value of 96.0 will equal to an A in the same index in the char array.
 * 
 * After both arrays are filled, the contents of those arrays will be displayed by passing those arrays onto the method printStudentData.
 * The double array will be passed to the method findArrayAverage to calculate and display the average of the array
 * and the char array will be passed to the method letterGradesTotal to calculate and display the sum of each letters. 
 * 
 * @author     Astillo, Lyle
 */

public class ArrayManipulation {
   
   public static void main(String[] args) {
   
      // Creating a scanner object and declaring a variable to be used to take user input.
      Scanner keyboard = new Scanner(System.in);
      int userIn;
      
      // Creating arrays to store randomly generated numbers and there letter grade equivalent.
      double [] midtermScores = new double[60];
      char [] letterGrades = new char[midtermScores.length];
      
      /*Fills midtermScores with randomly generated numbers ranging from 75.0 - 100.0.
        Translates scores into letter equivalent (e.g., 90.0+ = A, 80.0+ = B, 79 and bellow = C)
        and store those letter grades in letterGrades.*/
      for (int i = 0; i < midtermScores.length; i++) {
         
         midtermScores[i] = 75 + (Math.random() * 25);
            
         if (midtermScores[i] >= 90.0) {
            letterGrades[i] = 'A';
         }
         else if (midtermScores[i] >= 80.0) {
            letterGrades[i] = 'B';
         }
         else {
            letterGrades[i] = 'C';
         }
      }
      
      // Outputs contents of midtermScores[] by passing it to printStudentData (w/ double[] parameter).
      System.out.println("Printing test scores\n");
      printStudentData(midtermScores);
      
      // Outputs average of midterScores[] by passing it to findArrayAverage.
      System.out.println("\nThe average test score is: " + findArrayAverage(midtermScores));
      
      // Outputs contents of letterGrades[] by passig it to printStudentData (w/ char[] parameter).
      System.out.println("\nHere are the letter grade equivalent of the test scores\n");
      printStudentData(letterGrades);
      
      // Outputs the total of each letter grades in letterGrades[] by passing it to letterGradesTotal.
      System.out.println("\nThe total letter grades:\n" + letterGradesTotal(letterGrades) + "\n");
      
      // Prompts user to enter their student number to.
      // Used to find their grade.
      System.out.println("What is your student number?");
      
      try {
      // Store user input in userIn
         userIn = keyboard.nextInt();
      
      // If user input is not within range(1-60) program ends and tells user to enter a number between 1-60.
         if (userIn < 1 || userIn > 60) {
            System.out.print("Your student number should be from 1-60.");
            System.exit(0);    
         }
      
      /*Outputs user's midtermScore and letterGrade based on their input.
      (i.e. if they entered 1) it will be passed to accessStudentData (with a double[] and char[] parameter) and
      it will display the score and the letter grade of student 1.*/
         System.out.print("\n" + accessStudentData(midtermScores, userIn) 
                         + accessStudentData(letterGrades, userIn));
      }
      catch (InputMismatchException e) {
         System.out.print("Please enter your student number in integer format");
      }
   }
      
   /**
    * A method that prints the contents of an array.
    *
    * @param   scores   Used to take a double array.
    * @return  None.
    * @exceptions None.
    */
   public static void printStudentData(double[] scores) {
      
      // Used to label student number.   
      int startVal = 1; 
      
      for (int i = 0; i < scores.length; i++) {
         System.out.printf("Student %d: %.1f%n", startVal++, scores[i]);
      }
   }

   /**
    * A method that prints the contents of an array.
    *
    * @param   letters  Used to take a char array.
    * @return  None.
    * @exceptions None.
    */
   public static void printStudentData(char[] letters) {
      
      // Used to label student number.
      int startVal = 1;
      
      for (int i = 0; i < letters.length; i++) {
         System.out.printf("Student %d: %c%n", startVal++, letters[i]);
      }
   }
   
   /**
    * A method used to calculate the average of the elements in an array
      and count how many elements are greater than the average.
    *
    * @param   scores   Used to take a double array.  
    * @return  average  A string that contains the average of the contents of the double array and 
                        the ammount of the elements greater than the average.
    * @exceptions None.
    */
   public static String findArrayAverage(double[] scores) {
      
      // Used to store total of the array.
      // Used to count how many elements in the array are greater than average.
      double total = 0.0;
      int startVal = 0;
      double classAvg;
      
      for (int i = 0; i < scores.length; i++) {
         total += scores[i];
      }
      
      // Calculates the average of the array.
      classAvg = total / scores.length;
   
      for (int i = 0; i < scores.length; i++) {
         if (scores[i] > classAvg) {
            startVal++;
         }
      }
      String average = String.format("%.2f%n%d%s", classAvg, startVal, " students scored above the average.\n");
      return average;
   }
   
   /** 
    * A method used to count the sum of each letters in an array.
    *
    * @param   letters  Used to take a char array.
    * @return  classLetterGrades A string that contains the sum of each letters within the array.
    * @exceptions None.
    */
   public static String letterGradesTotal(char[] letters) {
   
      // Used to count how many elements are As, Bs, and Cs.
      int allA = 0, allB = 0, allC = 0;
      
      for (int i = 0; i < letters.length; i++) {
         if (letters[i] == 'A') {
            allA++;
         }
         else if (letters[i] == 'B') {
            allB++;
         }
         else if (letters[i] == 'C') {
            allC++;
         }
      }
      String classLetterGrades = String.format(allA + " students scored an A\n" +
                                               allB + " students scored a B\n" +
                                               allC + " students scored a C\n" +
                                               "0 students scored a D\n" +
                                               "0 students scored an F\n");
      return classLetterGrades;
   }
   
   /**
    * A method used to find a value within an array based on a given value using linear search.
    *
    * @param   scores   Used to take a double array.
    * @param   input    Used to take an integer to find a value in the array.
    * @return  userScore   A string that contains a value that was searched for based on the integer param.
    * @exceptions None.
    */
   public static String accessStudentData(double[] scores, int input) {
      
      // Used to match user input with the possition of their information within the array.
      // Once found, store that information into score.
      int counter = 1;
      double score = 0.0;
      
      for (int i = 0; i < scores.length; i++){
         if (input == counter) {
            score = scores[i];
         }
         counter++;
      }
      String userScore = String.format("%s%.1f%s%n", "You got a ", score, " on the test!");
      return userScore;
   }

   /**
    * A method used to find a value on an array based on a given value using linear search.
    *
    * @param   letters  Used to take a char array.
    * @param   input    Used to take an integer to find a value in the array.
    * @return  userLetterGrade   A string that contains a value that was searched for based on the integer param.
    * @exceptions None.
    */
   public static String accessStudentData(char[] letters, int input) {
      
      // Used to match user input with the possition of thir information within the array.
      // Once found, store that information into letterGrade.
      int counter = 1;
      char letterGrade = ' ';
      
      for (int i = 0; i < letters.length; i++) {
         if (input == counter) {
            letterGrade = letters[i];
         }
         counter++;
      }
      String userLetterGrade = String.format("Thats equivalent to the letter grade: " + letterGrade + "\nNice!");
      return userLetterGrade; 
   }
}