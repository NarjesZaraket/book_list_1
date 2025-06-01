import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/models/goals.dart';
import 'package:book_list_1/widgets/goals_card.dart';
import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key, required this.goalsList, required this.onDeleteGoal, 
    required this.availableBooks, required this.openAddBookOverlay, required this.currentlyReading,
    required this.favorite, required this.onDeteteBook});
  final List<Goals> goalsList;
  final List<Book> currentlyReading;
  final List<Book> favorite;
  final void Function(Goals) onDeleteGoal;
  final List<Book> availableBooks;
  final void Function() openAddBookOverlay;
  final Function(Book) onDeteteBook;

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          'No Goals yet!\nGo Start Some!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
    if (widget.goalsList.isNotEmpty) {
      mainContent = Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.goalsList.length,
            itemBuilder: (context, index) => Dismissible(
              background: Container(
                padding: EdgeInsets.only(left: 12),
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white, size: 25,),
              ),
              key: ValueKey(widget.goalsList[index]), 
              child: GoalsCard(goal: widget.goalsList[index], currentlyReading: widget.currentlyReading,
                                favorite: widget.favorite,
                                onDeteteBook: widget.onDeteteBook,),
              onDismissed: (direction) {
                widget.onDeleteGoal(widget.goalsList[index]);
                widget.currentlyReading.remove(widget.goalsList[index].bookToFinish);
              },
              ) 
            ),
        ),
      ],
    );
    }

    return Scaffold(
      appBar: AppBar(title: Text('My Goals'),),
   body:
    mainContent,
    
    floatingActionButton: FloatingActionButton(
          onPressed: widget.openAddBookOverlay,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Icon(Icons.add),
          ),
    );
  }
}