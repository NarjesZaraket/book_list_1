import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/models/goals.dart';
import 'package:book_list_1/screens/tabs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});
  final List<Book> bookList = [
    Book(title: 'Pride and Prejudice', author: 'Jane Auston', genre: Genre.romance, summary: "A romance story"),
    Book(title: 'Pet Sematary', author: 'Stephan King', genre: Genre.horror, summary: 'a horror story'),
    Book(title: 'Harry Potter 1', author: 'JK Rowling', genre: Genre.fiction, summary: 'a story filled with magic')
  ];

  final List<Goals> goals = [];
  final List<Book> favorites = [];
  final List<Book> currentlyReading = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabsScreen(bookList: bookList, goals: goals,currentlyReading: currentlyReading,
              favorites: favorites,)
    );
  }
}
