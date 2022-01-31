/**
 * An object class that is used to create all KbbExceptions by extending the Exception class.
 * 
 * @author     Astillo, Lyle
 */
 
public class KbbqException extends Exception {
 
   // Instance variable to hold custom exception messages.
   private String message = "";
   
   // Constructor used to create KbbqExceptions.
   public KbbqException() {
   }
   
   // Setter
   public void setMessage(String newMessage) {
      this.message = newMessage;
   }
   
   // Getter
   public String getMessage() {
      return this.message;
   }
}