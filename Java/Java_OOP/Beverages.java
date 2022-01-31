/**
 * Object class that is used to create a Beverages object that simulates ordering at a Kbbq resturant.
 * 
 * @author     Astillo, Lyle
 */
 
public class Beverages {

   // Instance Varialbles
   private String type, served = " "; // type must be in the dranks[] in setType() to be valid. served must be bottles if type is soju and both for other types.
   private int quantity = 0; // min of 1 and if ordering Soju or Beer no more than 5 at once.
   
   /**
    * The constructor for this used to create a Beverages object.
    * 
    * @param   type        takes a string to make a Beverages object.           
    * @param   served      takes a string to make a Beverages object.
    * @param   quantity    takes a double that is then converted to integer to make a Beverages object.
    * @exceptions KbbqException  if type passed is not within dranks[].
                                 if type is Soju and served pass is not Bottle.
                                 if served is not Bottles or Glass.  
                                 if type is Soju or Beer and quantity is > 5 
                                 if quantity < 1.                               
    */
   public Beverages(String type, String served, double quantity) throws KbbqException{
      setType(type);
      setServed(served);
      setQuantity((int)quantity);
   }
    
   // Getters
   public String getType() {
      return this.type;
   }
   public String getServed() {
      return this.served;
   }
   public int getQuantity() {
      return this.quantity;
   }
    
   /**
    * Setter that is used to change and validate the instance varaible type.
    * 
    * @param         newType              takes a string then validated in order to create a Beverages object or change the instance variable type.
    * @exceptions    KbbqException ke1    if newType is not within dranks[], tell user "Please read the menu!".
    */ 
   public void setType(String newType) throws KbbqException {
      String[] dranks = {"Soju", "Beer", "Soda", "Water"};
      boolean inMenu = false;
      for (int i = 0; i < dranks.length; i++) {
         if (dranks[i].equalsIgnoreCase(newType)) {
            inMenu = true;
         }
      }
      if (inMenu == true) {
         this.type = newType;
      }
      else {
         KbbqException ke1 = new KbbqException();
         ke1.setMessage("Please read the menu!");
         throw ke1;
      }   
   }

   /**
    * Setter that is used to change and validate the instance varaible served.
    * 
    * @param         newServed            takes a string then validated in order to create a Beverages object or change the instance variable served.
    * @exceptions    KbbqException ke2    if newType is soju and newServed is not bottle, tell user "We only sell Sojus per bottle."
                                   ke3    if newType is not bottle and glass, tell user "We only serve drinks in its bottle or on a separate glass."
    */
   public void setServed(String newServed) throws KbbqException{  
      if (this.type.equalsIgnoreCase("Soju") && !newServed.equalsIgnoreCase("Bottle")) {
         KbbqException ke2 = new KbbqException();
         ke2.setMessage("We only sell Sojus per bottle.");
         throw ke2;
      }
      else if (!newServed.equalsIgnoreCase("Bottles") && !newServed.equalsIgnoreCase("Glass")) {
         KbbqException ke3 = new KbbqException();
         ke3.setMessage("We only serve drinks in its bottle or on a separate glass.");
         throw ke3;
      }
      else {
         this.served = newServed;
      }
   } 
     
   /**
    * Setter that is used to change and validate the instance variable quantity.
    * 
    * @param         newQuantity          takes an integer then validated in order to create a Beverages object or change the instance variable quantity.
    * @exceptions    KbbqException ke4    if newQuantity is > 5 and type is soju or beer, tell user "You can only order 5 alcoholic drinks at a time."
                                   ke5    if newQuantity is < 1, tell user "It is store policy that you have something to drink with your meal."
    */
   public void setQuantity(int newQuantity) throws KbbqException {
      if (newQuantity > 5 && (this.type.equalsIgnoreCase("Soju") || this.type.equalsIgnoreCase("Beer"))) {
         KbbqException ke4 = new KbbqException();
         ke4.setMessage("You can only order 5 alcoholic drinks at a time.");
         throw ke4;
      }  
      else if (newQuantity < 1) {
         KbbqException ke5 = new KbbqException();
         ke5.setMessage("It is store policy that you have something to drink with your meal.");
         throw ke5;
      }  
      else {
         this.quantity = newQuantity;
      }
   }       
       
    /**
    * toString method that returns a string containg all the information about the Beverages object.
    * EX: For your drinks, you ordered 4 bottles of water.
    *       
    * @return  beverageObject   a string containing contents of the instance variables for a Beverages object.
    */
   public String toString() {
      String beverageObject = String.format("For you drinks, you orderd %d of %s %s.", this.quantity, this.served, this.type);
      return beverageObject;
   }
}