import 'package:book_list_1/models/book.dart';
import 'package:flutter/material.dart';
import 'package:book_list_1/models/goals.dart';
import 'package:intl/intl.dart';

class NewGoal extends StatefulWidget {
  const NewGoal({super.key, required this.addNewGoal, required this.bookList});
  final Function(Goals) addNewGoal;
  final List<Book> bookList;

  @override
  State<NewGoal> createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  Book? _selectedBook;
  DateTime? _selectedDate;

  void _showDatePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitGoalForm() {
    if (_selectedBook == null || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Missing Info'),
          content: const Text('Please select a book and a due date.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            )
          ],
        ),
      );
      return;
    }

    final newGoal = Goals( bookId: _selectedBook?.id ?? -1,bookToFinish: _selectedBook!, 
                            dueDate: _selectedDate!);
    widget.addNewGoal(newGoal);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text('Add New Goal', style: TextStyle(color: Colors.white, fontFamily: 'Cinzel',),),
              backgroundColor: const Color.fromARGB(225, 78, 7, 20),
              iconTheme: IconThemeData(color: Colors.white,)
              ),
      body:
    Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          DropdownButton<Book>(
            hint: const Text('Select Book'),
            value: _selectedBook,
            isExpanded: true,
            items: widget.bookList.map((book) {
              return DropdownMenuItem<Book>(
                value: book,
                child: Text(book.title),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedBook = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'No Date Selected'
                      : 'Due: ${DateFormat.yMMMd().format(_selectedDate!)}',
                ),
              ),
              IconButton(
                onPressed: _showDatePicker,
                icon: const Icon(Icons.calendar_today),
              )
            ],
          ),
          const SizedBox(height: 16),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(225, 78, 7, 20),
                  foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitGoalForm,
                style: ElevatedButton.
                          styleFrom(backgroundColor: const Color.fromARGB(225, 78, 7, 20), 
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                child: const Text('Save Goal'),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}