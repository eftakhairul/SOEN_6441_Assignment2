// C. Constantinides, 2013.

public class Book extends PrintedItem {

  String author;

  Book (String author, String title, String publisher, String year, String isbn) {
    super(title, publisher, year, isbn);
    this.author = author;
  }

}

