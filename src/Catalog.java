// C. Constantinides, 2013.

import java.util.*;
public class Catalog {
	ArrayList <Book> catalog = new ArrayList<Book> ();
	public void makeNewBook(String author, String title, String publisher, String year, String isbn) {
		Book book = new Book (author, title, publisher, year, isbn); 
		catalog.add(book);
    }
}
