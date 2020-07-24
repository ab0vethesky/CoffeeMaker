package coffeemaker;

/**
 * 
 * @author Oladipo
 *
 * TraceAspect - for question 2
 */

import coffeemaker.Inventory;
import coffeemaker.CoffeeMaker;

public privileged aspect TraceAspect 
{ 	
	
	int MAX_UNIT = 30; // declare a varaible to hold the maximum allowed value for the inventory items
	// ====== pointcuts ======= 
	pointcut setterX ( Inventory p ): call ( public void Inventory+.set*(*)) && target (p);
	pointcut setterXonly ( Inventory p ): setterX (p) && ! cflow ( execution(boolean CoffeeMaker.addInventory(int)));
	
	pointcut invocation(CoffeeMaker c): this(c) && call(boolean CoffeeMaker.addInventory(int));
	
	// ====== advices ====== 

	/**
	 * This part of the code gets the old and new values and print them to the console
	 */
	void around( Inventory p ): setterXonly (p) 
	{ 
		
		int oldCoffee = Inventory.coffee;     
		int oldMilk = Inventory.milk;
		int oldSugar = Inventory.sugar;
		int oldChocolate = Inventory.chocolate;
		
		int arrValue = (int)thisJoinPoint.getArgs()[0]; // Get the values returned by the methods
		
		String methodName = thisJoinPointStaticPart.getSignature().getName(); // Get the method names
		String methodStr = methodName.replace("set",""); // Some string manipulation, just for comparison and trapping the calls
		String [] items ={"Coffee", "Milk", "Sugar", "Chocolate"}; // Some strings for comparing with the methods
		int [] items_a = {oldCoffee, oldMilk, oldSugar, oldChocolate};
		
		// This block limits the methods to only the ones we are concerned with
		if ((methodName == "setCoffee") 
				|| (methodName  == "setMilk") 
				|| (methodName  == "setSugar") 
				|| (methodName  == "setChocolate"))
			
			// Loop through the methods and print the corresponding return values
			{
				for (int i = 0; i < items_a.length; i++) 
				{
					/** if the current method matches the items in the array, print 
					 * the corresponding values
					 */
	            	if (items[i].equals(methodStr)) 
		            	{   
	            			// Print the Old and New values for each of the methods
		            		System.out.println(
		            							"Old " + methodStr + 
		            							" Value = " + items_a[i] + 
		            							" New "+ methodStr + 
		            							" Value = " +  arrValue
		            							);            		
		                } 
	
	            }
			}
			
		proceed(p); 		
	} 
	
	/**
	 * This part of the code resets the inventory values to 30 if the
	 * resulting values are more than the limit set earlier
	 */
	after ( Inventory p ): setterX (p)
	{ 
		int oldCoffee = Inventory.coffee;     
		int oldMilk = Inventory.milk;
		int oldSugar = Inventory.sugar;
		int oldChocolate = Inventory.chocolate;
		
		/**
		 * 
		 * This part of the code resets the property to 30 and prints a message  to the console
		 * if the resulting values are more than the limit set earlier
		 * 
		 */
		if(oldCoffee > MAX_UNIT)
		{
			System.out.println("Coffee was reset to 30! ");
			Inventory.coffee = MAX_UNIT;					
		}
		
		else if(oldMilk > MAX_UNIT)
		{
			System.out.println("Milk was reset to 30! ");
			Inventory.milk = MAX_UNIT;					
		}
		else if(oldSugar > MAX_UNIT)
		{
			System.out.println("Sugar was reset to 30! ");
			Inventory.sugar = MAX_UNIT;					
		}
		else if(oldChocolate > MAX_UNIT)
		{
			System.out.println("Chocolate was reset to 30! ");
			Inventory.chocolate = MAX_UNIT;					
		}
	}
}