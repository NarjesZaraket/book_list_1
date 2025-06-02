import 'package:book_list_1/db/database.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/models/goals.dart';

void insertGoal(Goals goal) async {
  // get an instance of the database
  BookDatabase database = BookDatabase();
  final db = await database.getDatabase();
  // insert expense into the database
  db.insert('goals', goal.goalDetails);
}

Future<List<Goals>> loadGoals() async {
  final database = BookDatabase();
  final db = await database.getDatabase();

  final result = await db.query('goals');

  List<Goals> resultList = [];

  for (final row in result) {
    // First get the bookId from the goal row
    final int bookId = int.parse(row['bookId'].toString());

    // Query the books table for this specific book
    final bookResult = await db.query(
      'books',
      where: 'id = ?',
      whereArgs: [bookId],
    );

    // If the book exists, create a Book object
    if (bookResult.isNotEmpty) {
      final book = Book.fromMap(bookResult.first);

      final goal = Goals(
        id: int.parse(row['id'].toString()),
        bookToFinish: book,
        bookId: bookId,
        dueDate: DateTime.fromMillisecondsSinceEpoch(int.parse(row['goalDate'].toString())),
      );
      resultList.add(goal);
    }
  }

  return resultList;
}

void deleteGoal(Goals goal) async {
  // get an instance of the database
  BookDatabase database = BookDatabase();
  final db = await database.getDatabase();
  // delete an expense with a specific id
  db.delete('goals', where: 'id = ?', whereArgs: [goal.id]);
}