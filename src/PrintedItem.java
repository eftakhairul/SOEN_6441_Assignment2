// C. Constantinides, 2013.

abstract class PrintedItem {

  String title;
  String publisher;
  String year;
  String isbn;

  PrintedItem (String title, String publisher, String year, String isbn) {
    this.title = title;
    this.publisher = publisher;
    this.year = year;
    this.isbn = isbn;
  }

  public String getIsbn () {
    return isbn;
  }

}
