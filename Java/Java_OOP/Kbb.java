/**
 * Driver class that creates two objects form two different object claseses.
 *  
 * @author     Astillo, Lyle
 */
 
public class Kbb {

   public static void main(String[] args) {
      System.out.println("This program simulates a small Korean BBQ resturant's ordering system." + 
                        "\nThis class is used to create a Meats and Beverages objects and use the methods and exceptions within those classes.\n");   
      try {
         // Creating a valid Meats object.
         Meats order1 = new Meats("bulgogi", 3, "rice");
         System.out.println(order1);
         
         // Creating a valid Beverages object.
         Beverages dranks1 = new Beverages("beer", "bottles", 3);
         System.out.println(dranks1);
         
         // Calling 2 setters from Meats class to change order1 type and quantity.
         // Calling 2 getters from Meats class to verify changes. 
         order1.setType("Chaldol");
         order1.setQuantity(2);
         System.out.printf("%nYou ordered %d pieces of %s.%n", order1.getQuantity(), order1.getType());
         
         // Calling 2 setters from Beverages class to change dranks1 type and quantity.
         // Calling 2 getters form Beverages class to verify changes.
         dranks1.setType("Soju");
         dranks1.setQuantity(2);
         System.out.printf("You ordered %d bottles of %s.%n%n", dranks1.getQuantity(), dranks1.getType());
         
         // Creating an invalid Meats object.
         // Uncommnent line to see.
         // Meats invalidOrder1 = new Meats("Nigiri", 12, "Gari"); // Throws exception because Nigiri does not exist in the beef[] in setType() in Meats class.
         
         // Creating an invalid Beverages object.
         // Uncommnent line to see.
         // Beverages invalidOrder2 = new Beverages("Cold Sake", "Jar", 10); // Throws exception because Cold Sake does not exist in the dranks[] in setType() in Beverages class.
      
         // Calling 1 setter for from each object class and passing argurments that causes exceptions being thrown.
         // Uncomment order1.setSide("Lumpia") to see.
         dranks1.setQuantity(6); // Throws exception because dranks.setType was recently passed soju and can only have 5 alcoholic drinks per order.
         //order1.setSide("Lumpia"); // Throws exception because Lumpia does not exist on the sides[] in setSide() in Meats class.
      }
      catch (KbbqException ke) {
         System.out.print(ke.getMessage());
      }
   }
}