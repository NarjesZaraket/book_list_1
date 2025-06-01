import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/models/goals.dart';
import 'package:book_list_1/screens/all_books.dart';
import 'package:book_list_1/screens/favorites.dart';
import 'package:book_list_1/screens/goals_screen.dart';
import 'package:book_list_1/screens/home_page.dart';
import 'package:book_list_1/screens/new_book.dart';
import 'package:book_list_1/screens/new_goal.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.bookList, required this.goals, 
        required this.currentlyReading, required this.favorites});
  final List<Book> bookList;
  final List<Book> currentlyReading;
  final List<Goals> goals;
  final List<Book> favorites;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void _addNewBook(Book book) {
    setState(() {
      // now, when you want to use registeredExpensesList in the State class, you use the widget varaible
      widget.bookList.add(book);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Book Added"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              widget.bookList.remove(book);
              // insret the expense again if the user revert the action
              //insertExpense(expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddBookOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewBook(addNewBook: _addNewBook),
    );
  }

  void _selectPage(int index) {
    if (index == 2) {
    _openAddBookOverlay(); // Trigger the modal
    return; // Do NOT update the selected index
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  void _deleteBook(Book book) {
    setState(() {
      widget.bookList.remove(book);
      // delete the expense from the database
      //deleteExpense(expense);
    });
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Deleting Book'),
          content: Text('Are you sure you want to delete ${book.title}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            )
          ]
        )
    );
  }

  void _addNewGoal(Goals goal) {
    setState(() {
      // now, when you want to use registeredExpensesList in the State class, you use the widget varaible
      widget.goals.add(goal);
        });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Goal Added"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              widget.goals.remove(goal);
              // insret the expense again if the user revert the action
              //insertExpense(expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddGoalOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewGoal(addNewGoal: _addNewGoal, bookList: widget.bookList),
    );
  }
  void _deleteGoal(Goals goal) {
    int index = widget.goals.indexOf(goal);
    setState(() {
      widget.goals.remove(goal);
      // delete the expense from the database
      //deleteExpense(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Book Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              widget.goals.insert(index, goal);
              // insret the expense again if the user revert the action
              //insertExpense(expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Book book = Book(title: 'Harry Potter 1', author: 'JK Rowling', 
    genre: Genre.fiction, summary: 'a story filled with magic');

    Widget activeScreen= HomePage(currentlyReadingList: widget.currentlyReading, 
      favorite: widget.favorites, onDeteteBook: _deleteBook,);
    if(_selectedIndex == 1)
    {
      activeScreen = AllBooksList(allBooksList: widget.bookList, 
              currentlyReading: widget.currentlyReading,
              favorite: widget.favorites,
              onDeteteBook: _deleteBook,);
    }
    if(_selectedIndex == 3)
    {
      activeScreen = FavoritesScreen(favorites: widget.favorites, 
                      currentlyReading: widget.currentlyReading,
                      onDeteteBook: _deleteBook,);
    }
    if(_selectedIndex == 4)
    {
      activeScreen = GoalsScreen(goalsList: widget.goals, onDeleteGoal: _deleteGoal, 
                      availableBooks: widget.bookList, openAddBookOverlay: _openAddGoalOverlay,
                      currentlyReading: widget.currentlyReading,
                      favorite: widget.favorites,
                      onDeteteBook: _deleteBook,);
    }
    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'All'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Book'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: 'Goals'),
        ],
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        ),
    );
  }
}