import 'package:book_list_1/db/database.dart';
import 'package:book_list_1/models/book.dart';

void insertBook(Book book) async {
  // get an instance of the database
  BookDatabase database = BookDatabase();
  final db = await database.getDatabase();
  // insert expense into the database
  db.insert('books', book.bookDetails);
}

Future<List<Book>> loadBooks() async {
  final db = await BookDatabase().getDatabase();
  final List<Map<String, dynamic>> maps = await db.query('books');

  // DEBUG: Check what's actually stored
  for (var map in maps) {
    print('Book ${map['id']} - isReading: ${map['isReading']}, isFavorite: ${map['isFavorite']}');
  }

  return maps.map((map) => Book.fromMap(map)).toList();
}

void deleteBook(Book book) async {
  // get an instance of the database
  BookDatabase database = BookDatabase();
  final db = await database.getDatabase();
  // delete an expense with a specific id
  db.delete('books', where: 'id = ?', whereArgs: [book.id]);
}

Future<void> updateFavoriteStatus(int bookId, bool isFavorite) async {
  BookDatabase database = BookDatabase();
  final db = await database.getDatabase();

  await db.update(
    'books',
    {
      'isFavorite': isFavorite ? 1 : 0,
    },
    where: 'id = ?',
    whereArgs: [bookId],
  );

  final result = await db.query('books', where: 'id = ?', whereArgs: [bookId]);
  print('Updated Book (isFavorite): ${result.first}');
}

Future<void> updateReadingStatus(int bookId, bool isReading) async {
  BookDatabase database = BookDatabase();
  final db = await database.getDatabase();

  await db.update(
    'books',
    {
      'isReading': isReading ? 1 : 0,
    },
    where: 'id = ?',
    whereArgs: [bookId],
  );

  final result = await db.query('books', where: 'id = ?', whereArgs: [bookId]);
  print('Updated Book (isReading): ${result.first}');
}