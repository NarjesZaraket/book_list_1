import 'package:book_list_1/models/book.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.book, required this.currentlyReading,
        required this.favorite, required this.onDeteteBook});
  final Book book;
  final List<Book> currentlyReading;
  final List<Book> favorite;
  final Function(Book) onDeteteBook;
  @override
  State<StatefulWidget> createState() {
    return _BookDetailsState();
  }
}

class _BookDetailsState extends State<BookDetails>{
  void _startReading()
  {
    setState(() {
      widget.book.isReading = true;
      if (!widget.currentlyReading.contains(widget.book)) {
        widget.currentlyReading.add(widget.book);
      }
    });
  }
  void _markAsDone() {
    setState(() {
      widget.book.isReading = false;
      widget.currentlyReading.remove(widget.book);
    });
  }

  void _favorite()
  {
    setState(() {
      widget.book.isFavorite = true;
      widget.favorite.add(widget.book);
    });
  }
  void _notFavorite()
  {
    setState(() {
      widget.book.isFavorite = false;
      widget.favorite.remove(widget.book);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.book.title}'),
              actions: [
                  IconButton(
                         onPressed: widget.book.isFavorite ? _notFavorite : _favorite,
                         icon: Icon(
                                widget.book.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: widget.book.isFavorite ? Colors.red : Colors.black,
                                ),
                         iconSize: 30,),
                  IconButton(
                    onPressed: () =>widget.onDeteteBook(widget.book), 
                    icon: Icon(Icons.delete_outline),
                    iconSize: 30,),
              ],
              ),
      body: 
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect( 
                borderRadius: BorderRadius.circular(16),
                child:              
                Image.asset(genreImage[widget.book.genre]!),
              ),
              SizedBox(height: 20),
              Text('Written By: ${widget.book.author}', style: TextStyle(fontSize: 20),),
              SizedBox(height: 20),
              Text('Genre: ${widget.book.genre.name}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Text('Summary: ${widget.book.summary}', style: TextStyle(fontSize: 20)),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: widget.book.isReading ? _markAsDone : _startReading, 
                      style: ElevatedButton.
                      styleFrom(backgroundColor: const Color.fromARGB(108, 170, 125, 12), 
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      child: Text(widget.book.isReading ? 'Done' : 'Start Reading'),
                      ),
                  ),
                ],
              ),
            ]
            )
          ),
    );
  }
}
