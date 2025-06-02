import 'package:book_list_1/db/book_storage.dart';
import 'package:book_list_1/db/goals_storage.dart';
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
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Book> _bookList;
  late List<Goals> _goals;
  late List<Book> _favorites;
  late List<Book> _currentlyReading;

  int _selectedIndex = 0;

  void _addNewBook(Book book) {
    setState(() {
      // now, when you want to use registeredExpensesList in the State class, you use the widget varaible
      _bookList.add(book);
      insertBook(book);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Book Added"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _bookList.remove(book);
              deleteBook(book);
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

  void _deleteBook(Book book) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text('Yes'),
              )
            ],
            title: Text('Delete Book'),
            content: Text('Are you sure you want to delete this book?'),
          ),
    );
    if (confirm == true) {
      setState(() {
        _bookList.remove(book);
        _favorites.remove(book);
        _currentlyReading.remove(book);
        _goals.removeWhere((goal) => goal.bookId == book.id);

        deleteBook(book);
        updateFavoriteStatus(book.id!, false);
        updateReadingStatus(book.id!, false);

        Goals? goalToDelete;
        try {
          goalToDelete = _goals.firstWhere((goal) => goal.bookId == book.id);
        } catch (e) {
          goalToDelete = null;
        }

        if (goalToDelete != null) {
          deleteGoal(goalToDelete);
        }
      });
    }
  }

  void _addNewGoal(Goals goal) {
    setState(() {
      // now, when you want to use registeredExpensesList in the State class, you use the widget varaible
      _goals.add(goal);
      insertGoal(goal);
        });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Goal Added"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _goals.remove(goal);
              deleteGoal(goal);
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
      builder: (ctx) => NewGoal(addNewGoal: _addNewGoal, bookList: _bookList),
    );
  }
  void _deleteGoal(Goals goal) {
    int index = _goals.indexOf(goal);
    setState(() {
      _goals.remove(goal);
      deleteGoal(goal);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Book Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _goals.insert(index, goal);
              insertGoal(goal);
            });
          },
        ),
      ),
    );
  }

  

  @override
  void initState() {
    super.initState();
    // Initialize local lists as copies of widget data
    _bookList = []; 
    _goals = [];
    _favorites = [];
    _currentlyReading = [];

    _loadDataFromDb();
  }

  bool _isLoading = true;
  void _loadDataFromDb() async {
    final books = await loadBooks();
    final goals = await loadGoals();

    setState(() {
      _bookList = books;
      _goals = goals;
      _favorites = books.where((book) => book.isFavorite).toList();
      _currentlyReading = books.where((book) => book.isReading).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget activeScreen = HomePage(
      currentlyReadingList: _currentlyReading,
      favorites: _favorites,
      onDeteteBook: _deleteBook,
      onBookUpdate: _loadDataFromDb,
    );
    if(_selectedIndex == 1)
    {
      activeScreen = AllBooksList(
        allBooksList: _bookList,
        currentlyReading: _currentlyReading,
        favorites: _favorites,
              onDeteteBook: _deleteBook,
              onBookUpdate: _loadDataFromDb,);
    }
    if(_selectedIndex == 3)
    {
      activeScreen = FavoritesScreen(
        favorites: _favorites,
        currentlyReading: _currentlyReading,
                      onDeteteBook: _deleteBook,
                      onBookUpdate: _loadDataFromDb,
                      );
    }
    if(_selectedIndex == 4)
    {
      activeScreen = GoalsScreen(
        goalsList: _goals,
        onDeleteGoal: _deleteGoal,
        availableBooks: _bookList,
        openAddBookOverlay: _openAddGoalOverlay,
        currentlyReading: _currentlyReading,
        favorites: _favorites,
                      onDeteteBook: _deleteBook,);
    }
    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(239, 235, 244, 100),           // background color of the bar
        selectedItemColor: const Color.fromARGB(225, 78, 7, 20),           // color of selected icon and label
        unselectedItemColor: const Color.fromARGB(100, 24, 43, 37),
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