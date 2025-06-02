import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/widgets/book_card.dart';

class AllBooksList extends StatefulWidget {
  const AllBooksList({super.key, required this.allBooksList, required this.currentlyReading,
    required this.favorites,
    required this.onDeteteBook,
    required this.onBookUpdate
  });
  final List<Book> allBooksList;
  final List<Book> currentlyReading;
  final List<Book> favorites;
  final Function(Book) onDeteteBook;
  final Function() onBookUpdate;


  @override
  State<AllBooksList> createState() => _AllBooksListState();
}

class _AllBooksListState extends State<AllBooksList> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          'No Books yet!\nStart Your Reading Journey Now!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,),
        ),
      ),
    );
    if (widget.allBooksList.isNotEmpty) {
      mainContent = GridView.builder(
      itemCount: widget.allBooksList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,         
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,), 
      itemBuilder: (ctx , index) => BookCard(book: widget.allBooksList[index], 
                          currentlyReading: widget.currentlyReading,
                          favorites: widget.favorites,
                          onDeteteBook: widget.onDeteteBook,
                          onBookUpdate: widget.onBookUpdate,)
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 235, 244, 100),
      appBar: AppBar(title: Text('All My Book', style: TextStyle(
        fontFamily: 'Cinzel',
        color: Colors.white),), 
      backgroundColor: const Color.fromARGB(225, 78, 7, 20),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mainContent,
      )
    );
    }
  }
