import 'package:book_list_1/models/book.dart';
import 'package:intl/intl.dart';

class Goals 
{
  Goals({this.id, this.bookToFinish, required this.dueDate, required this.bookId});

  //final Book bookToFinish;
  final DateTime dueDate;
  final int? id;
  final int bookId;
  Book? bookToFinish;

  String get formattedDate {
    return DateFormat.yMMMd().format(dueDate);
  }

  Map<String, Object> get goalDetails
  {
    return 
    {
      'bookId': bookId,
      'goalDate': dueDate.millisecondsSinceEpoch,
    };
  }

  factory Goals.fromMap(Map<String, dynamic> map, Book bookToFinish) {
    return Goals(
      id: map['id'],
      bookId: map['bookId'],
      dueDate: DateTime.parse(map['goalDate']),
    );
  }
}