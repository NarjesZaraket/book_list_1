import 'package:book_list_1/widgets/quotes.dart';
import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/widgets/book_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.currentlyReadingList, required this.favorite,
                  required this.onDeteteBook});
  final List<Book> currentlyReadingList;
  final List<Book> favorite;
  final Function(Book) onDeteteBook;

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
                            favorite: widget.favorite,
                            onDeteteBook: widget.onDeteteBook,));
    }
    return Scaffold(
      appBar: AppBar(title: Text('My Book List'),),
      body: 
      Column(
        children: [
          Quotes(),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Currently Reading',
                style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),
                ),
            ),
          ),
          SizedBox(height: 15,),
          mainContent
        ],
      ),
      
    );  }
}