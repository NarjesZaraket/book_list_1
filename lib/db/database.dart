import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookDatabase 
{
  Future<Database> getDatabase() async
  {
    String dbPath = await getDatabasesPath();
    Database db = await openDatabase(
      join(dbPath, 'book.db'),
      onCreate: 
      (db, version) {
        db.execute(
          'CREATE TABLE books(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, summary TEXT, genre TEXT, isReading INTEGER, isFavorite INTEGER)'
        );
        db.execute(
          'CREATE TABLE goals(id INTEGER PRIMARY KEY AUTOINCREMENT, bookId INTEGER, goalDate TEXT, FOREIGN KEY (bookId) REFERENCES books(id) ON DELETE CASCADE)'
        );
      },
      version: 1,
    );
    return db;
  }
}