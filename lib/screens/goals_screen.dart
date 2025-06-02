import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/models/goals.dart';
import 'package:book_list_1/widgets/goals_card.dart';
import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key, required this.goalsList, required this.onDeleteGoal, 
    required this.availableBooks, required this.openAddBookOverlay, required this.currentlyReading,
    required this.favorites,
    required this.onDeteteBook,
  });
  final List<Goals> goalsList;
  final List<Book> currentlyReading;
  final List<Book> favorites;
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
                color: const Color.fromARGB(255, 150, 23, 14),
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white, size: 25,),
              ),
              key: ValueKey(widget.goalsList[index]), 
              child: GoalsCard(goal: widget.goalsList[index], currentlyReading: widget.currentlyReading,
                      favorites: widget.favorites,
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
      backgroundColor: const Color.fromRGBO(239, 235, 244, 100),
      appBar: AppBar(title: Text('My Goals', style: TextStyle(color: Colors.white, fontFamily: 'Cinzel',),), 
        backgroundColor: const Color.fromARGB(225, 78, 7, 20),),
   body:
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: mainContent,
    ),
    
    floatingActionButton: FloatingActionButton(
          onPressed: widget.openAddBookOverlay,
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(225, 78, 7, 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Icon(Icons.add),
          ),
    );
  }
}