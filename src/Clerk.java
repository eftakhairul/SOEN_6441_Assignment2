// C. Constantinides, 2013.

public class Clerk {

	Terminal terminal;
	
	public Clerk (Terminal terminal){
		this.terminal = terminal;
	}
	
	public void simulateScenario() {
	    terminal.makeNewBookEntry();
	    terminal.addBook("Budd", "OOP with Java", "AW", "1997", "123456");
	    terminal.addBook("Fowler", "UML Distilled", "AW", "1997", "234567");
	    
	    terminal.endBookEntry();
	}
	
}
