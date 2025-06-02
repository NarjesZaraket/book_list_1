import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/widgets/book_list_widget.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, required this.favorites, required this.currentlyReading,
                        required this.onDeteteBook,
                        required this.onBookUpdate});
  final List<Book> favorites;
  final List<Book> currentlyReading;
  final Function(Book) onDeteteBook;
  final Function() onBookUpdate;

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
                    favorites: widget.favorites,
                    onDeteteBook: widget.onDeteteBook,
                    onBookUpdate: widget.onBookUpdate,);
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 235, 244, 100),
      appBar: AppBar(title: Text('My Favorite Book', style: TextStyle(
        fontFamily: 'Cinzel',
        color: Colors.white
      ),),
        backgroundColor: const Color.fromARGB(225, 78, 7, 20),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mainContent,
      )
    );
  }
}