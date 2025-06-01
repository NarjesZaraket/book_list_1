import 'package:book_list_1/models/book.dart';
import 'package:intl/intl.dart';

class Goals 
{
  Goals({required this.bookToFinish, required this.dueDate});

  final Book bookToFinish;
  final DateTime dueDate;

  String get formattedDate {
    return DateFormat.yMMMd().format(dueDate);
  }

  Map<String, Object> get goalDetails
  {
    return 
    {
      'Book': bookToFinish,
      'Finish By': dueDate.millisecondsSinceEpoch,
    };
  }
}