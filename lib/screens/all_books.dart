import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/widgets/book_card.dart';

class AllBooksList extends StatefulWidget {
  const AllBooksList({super.key, required this.allBooksList, required this.currentlyReading,
                      required this.favorite, required this.onDeteteBook});
  final List<Book> allBooksList;
  final List<Book> currentlyReading;
  final List<Book> favorite;
  final Function(Book) onDeteteBook;


  @override
  State<AllBooksList> createState() => _AllBooksListState();
}

class _AllBooksListState extends State<AllBooksList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All My Book'),),
      body: 
    GridView.builder(
      itemCount: widget.allBooksList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,         
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,), 
      itemBuilder: (ctx , index) => BookCard(book: widget.allBooksList[index], 
                          currentlyReading: widget.currentlyReading,
                          favorite: widget.favorite,
                          onDeteteBook: widget.onDeteteBook,)
      )
    );
    }
  }
