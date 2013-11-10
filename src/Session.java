// C. Constantinides, 2013.

public class Session {

  protected Catalog catalog;
  protected boolean isComplete;


  // constructor
  Session(Catalog catalog) {
    this.catalog = catalog;
  }

  public void initiate() {
      isComplete = false;
      System.out.println("Session started..." + "\n");
  }

  public void becomeComplete() {
    isComplete = true;
    System.out.println("Session completed." + "\n");
  }

  public boolean isComplete() {return isComplete;}

}

