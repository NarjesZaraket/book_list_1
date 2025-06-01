import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/widgets/book_card.dart';

class BookList extends StatelessWidget {
  const BookList({super.key, required this.bookList, required this.currentlyReading,
                  required this.favorite, required this.onDeteteBook});
  final List<Book> bookList;
  final List<Book> currentlyReading;
  final List<Book> favorite;
  final Function(Book) onDeteteBook;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: bookList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,         
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,), 
      itemBuilder: (ctx , index) => BookCard(book: bookList[index], 
                     currentlyReading: currentlyReading,
                     favorite: favorite,
                     onDeteteBook: onDeteteBook,)
      );
  }
}