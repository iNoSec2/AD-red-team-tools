/**
 * Object class that is used to create a Meats object that simulates ordering at a Kbbq resturant.
 * 
 * @author     Astillo, Lyle
 */
 
public class Meats {

   // Instance varialbles 
   private  String type, side = " "; // type must be in the beef[] in setType() and side must also be in sides[] in setSide() to be valid.
   private int quantity = 0; // must be between 1 - 4.
   
   /**
    * The constructor for this class used to create a Meats object.
    * 
    * @param   type        takes a string to make a Meats object.          
    * @param   quantity    takes a double that is then converted to integer to make a Meats object. 
    * @param   side        takes a string to make a Meats object.
    * @exceptions KbbqException  if type passed is not within beef[].
                                 if quantity passed is < 1 or > 5.
                                 if side passed is not within sides[].
    */
   public Meats(String type, double quantity, String side) throws KbbqException {
      setType(type);
      setQuantity((int)quantity);
      setSide(side);
   }
    
   // Getters
   public String getType() {
      return this.type;
   }
   public int getQuantity() {
      return this.quantity;
   }
   public String getSide() {
      return this.side;
   }
    
   /**
    * Setter that is used to change and validate the instance varaible type.
    * 
    * @param         newType              takes a string then validated in order to create a Meats object or change the instance variable type.
    * @exceptions    KbbqException ke1    if newType is not within beef[], tell user "Thats not on the menu!" 
    */
   public void setType(String newType) throws KbbqException{
      String[] beef =  {"New York Strip", "Chaldol", "Bulgogi", "Galbi", "Gobchang"};
      boolean inMenu = false;
      for (int i = 0; i < beef.length; i++) {
         if (beef[i].equalsIgnoreCase(newType)) {
            inMenu = true;
         }
      }       
      if (inMenu == true) {
         this.type = newType;
      }
      else { 
         KbbqException ke1 = new KbbqException();
         ke1.setMessage("Thats not on the menu!");
         throw ke1;
      }
   }

   /**
    * Setter that is used to change and validate the instance varaible quantity.
    * 
    * @param         newQuantity         takes an integer then validated in order to create a Meats object or change the instance variable quantity.
    * @exceptions    KbbqException ke2   if newQuantity is < 1 or > 5, tell user "You can only order 1 to 4 pieces at a time."
    */
   public void setQuantity(int newQuantity) throws KbbqException {
      if (newQuantity >= 1 && newQuantity <= 4) {
         this.quantity = newQuantity;
      }  
      else { 
         KbbqException ke2 = new KbbqException();
         ke2.setMessage("You can only order 1 to 4 pieces at a time.");
         throw ke2;
      }
   }
   
   /**
    * Setter that is used to change and validate the instance variable side.
    * 
    * @param         newSide              takes a string then validated in order to create a Meats object or change the instance variable side.
    * @exceptions    KbbqException ke3    if newSide is not within sides[], tell users "Thats not on the menu!" 
    */
   public void setSide(String newSide) throws KbbqException{
      String[] sides = {"Rice", "Kimchi", "Spicy Cucumber Salad"};
      boolean inMenu = false;
      for (int i = 0; i < sides.length; i++) {
         if (sides[i].equalsIgnoreCase(newSide)) {
            inMenu = true;
         }
      }
      if (inMenu == true) {
         this.side = newSide;
      }         
      else { 
         KbbqException ke3 = new KbbqException();
         ke3.setMessage("Thats not on the menu!");
         throw ke3;
      }
   }   
   
    /**
    * toString method that returns a string containg all the information about the Meats object.
    * EX: You ordered 3 pieces of galbi and a side of kimchi.
    *     
    * @return  meatObject   a string containing contents of the instance variables for a Meats object. 
    */
   public String toString() {
      String meatObject = String.format("You ordered %d pieces of %s and a side of %s.", this.quantity, this.type, this.side); 
      return meatObject;
   }
}