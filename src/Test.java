// C. Constantinides, 2013.

public class Test {
	  static public void main(String args[]) {
		  	Catalog catalog = new Catalog();  
		  	Terminal terminal = new Terminal(catalog);
		  	Clerk clerk = new Clerk(terminal);
		    clerk.simulateScenario();
		  }
}
