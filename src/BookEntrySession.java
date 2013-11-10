// C. Constantinides, 2013.

public class BookEntrySession extends Session {

  // constructor
  BookEntrySession(Catalog catalog) {
    super(catalog);
  }


  public void makeNewBook(String author, String title, String publisher, String year, String isbn) {
    if (isComplete())
      System.out.println("Out of sequence event." + "\n");
    else {
      catalog.makeNewBook(author, title, publisher, year, isbn);
      System.out.println("Book entered." + "\n");
    }

  }

}

