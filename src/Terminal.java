// C. Constantinides, 2013.

public class Terminal {

  private BookEntrySession bookEntrySession;
  private Catalog catalog;

  public Terminal(Catalog catalog){
	 this.catalog = catalog;
  }
  
  public void makeNewBookEntry() {
    BookEntrySession session =  new BookEntrySession(catalog);
    this.bookEntrySession = session;
    bookEntrySession.initiate();
  }

  public void addBook(String author, String title, String publisher, String year, String isbn) {
    bookEntrySession.makeNewBook(author, title, publisher, year, isbn);
  }

  public void endBookEntry() {
    bookEntrySession.becomeComplete();
  }


}

