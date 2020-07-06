package coffeemaker;

/**
 * 
 * @author Oladipo
 *
 * InputAspect  - for question 3
 */

public privileged aspect InputAspect 
{ 
	// Define the pointcut ccontaining the calls we want 
	pointcut checkInput() : call(int coffeemaker.Main.stringToInt(String));

	after() returning : checkInput()
	{
		/**
		 * Capture the value returned at the joinpoint 
		 */
		String vv = thisJoinPoint.getArgs()[0].toString();
		int arrValue = Integer.parseInt(vv);
		
		/**
		 * Send the joinpoint value for verification
		 */
		verifyInput(arrValue);		
		
	}

	/**
	 * 
	 * @param arrValue
	 * @return
	 * 
	 * Verifies the console input and prints a message to the console 
	 * if the value is less than 0
	 */
	public static int verifyInput(int arrValue)
	{

			if(arrValue < 0)
			{
				System.out.println("Only positive values are allowed, please re-enter the correct value from the main menu");
				Main.mainMenu();
			}
			return arrValue;	
	}
}