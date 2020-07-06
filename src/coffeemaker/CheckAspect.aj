package coffeemaker;

/**
 * 
 * @author Oladipo
 *
 * CheckAspect  - for question 1
 */

public privileged aspect CheckAspect 
{ 

	//pointcut setValue() : call(void Inventory.setCoffee()) || call(void Inventory.setMilk()) || call(void Inventory.setChocolate()) || call(void Inventory.setSugar())
	pointcut setValue() : 
	call(void coffeemaker.Recipe.setAmtCoffee(int)) 
	|| call(void coffeemaker.Recipe.setAmtMilk(int)) 
	|| call(void coffeemaker.Recipe.setAmtChocolate(int)) 
	|| call(void coffeemaker.Recipe.setAmtSugar(int));
	
	//pointcut checkInput() : 
	//	call(void coffeemaker.Inventory.setChocolate(int)) 
	//	|| call(void coffeemaker.Inventory.setMilk(int)) 
	//	|| call(void coffeemaker.Inventory.setChocolate(int)) 
	//	|| call(void coffeemaker.Inventory.setSugar(int));
	//pointcut getValue
	after() returning:setValue()
		{ 
		//System.out.println("I got here");
			if (!(Recipe.amtCoffee <= new Integer (30)))								
				{ 
					throw new IllegalArgumentException 
					(" Error : Recipes do not allow more than 30 units of Coffee Ingredient !"); 		
				}
			if (!(Recipe.amtMilk <= new Integer (30)))						
				{ 
					throw new IllegalArgumentException 
					(" Error : Recipes do not allow more than 30 units of Milk Ingredient !"); 
				} 
			 if (!(Recipe.amtSugar <= new Integer (30)))				
				{ 
					throw new IllegalArgumentException 
					(" Error : Recipes do not allow more than 30 units of Sugar Ingredient !"); 
				}											
			 if (!(Recipe.amtChocolate <= new Integer (30)))				
				{ 
					throw new IllegalArgumentException 
					(" Error : Recipes do not allow more than 30 units of Chocolate Ingredient !"); 
				}
								
		} 
}