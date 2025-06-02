import 'package:book_list_1/widgets/quotes.dart';
import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/widgets/book_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.currentlyReadingList,
    required this.favorites,
    required this.onDeteteBook,
    required this.onBookUpdate});
  final List<Book> currentlyReadingList;
  final List<Book> favorites;
  final Function(Book) onDeteteBook;
  final Function() onBookUpdate;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            'Not Reading Any.\nStart Now!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
    if (widget.currentlyReadingList.isNotEmpty) {
      mainContent = Expanded(child: BookList(bookList: widget.currentlyReadingList,
                            currentlyReading: widget.currentlyReadingList,
                            favorites: widget.favorites,
                            onDeteteBook: widget.onDeteteBook,
                            onBookUpdate: widget.onBookUpdate,));
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 235, 244, 100),
      appBar: AppBar(title: Text('My Book List', style: TextStyle(
        fontFamily: 'Cinzel',
        color: Colors.white,
      ),),
        backgroundColor: const Color.fromARGB(225, 78, 7, 20),),
      body: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Quotes(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Currently Reading',
                  style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(225, 78, 7, 20),),
                  ),
              ),
            ),
            SizedBox(height: 15,),
            mainContent
          ],
        ),
      ),
      
    );  }
}