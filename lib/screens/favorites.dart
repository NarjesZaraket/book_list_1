import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/widgets/book_list_widget.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, required this.favorites, required this.currentlyReading,
                        required this.onDeteteBook});
  final List<Book> favorites;
  final List<Book> currentlyReading;
  final Function(Book) onDeteteBook;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          'No Favorites yet!\nTap the ❤️ on a book to add it here',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
    if (widget.favorites.isNotEmpty) {
      mainContent = BookList(bookList: widget.favorites, currentlyReading: widget.currentlyReading, 
                    favorite: widget.favorites,
                    onDeteteBook: widget.onDeteteBook,);
    }
    return Scaffold(
      appBar: AppBar(title: Text('My Favorite Book'),),
      body: mainContent
    );
  }
}