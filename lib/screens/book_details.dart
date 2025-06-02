import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/db/book_storage.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.book, required this.currentlyReading,
    required this.favorites,
    required this.onDeteteBook,
  });
  final Book book;
  final List<Book> currentlyReading;
  final List<Book> favorites;
  final Function(Book) onDeteteBook;

  @override
  State<StatefulWidget> createState() {
    return _BookDetailsState();
  }
}

class _BookDetailsState extends State<BookDetails>{

  void _startReading() async
  {
    setState(() {
      widget.book.isReading = true;
      if (!widget.currentlyReading.contains(widget.book)) {
        widget.currentlyReading.add(widget.book);
      }
    });
      await updateReadingStatus(widget.book.id!, true);

  }
  void _markAsDone() async{
    setState(() {
      widget.book.isReading = false;
      widget.currentlyReading.remove(widget.book);
    });
    await updateReadingStatus(widget.book.id!, false);
  }

  void _favorite() async
  {
    setState(() {
      widget.book.isFavorite = true;
      widget.favorites.add(widget.book);
    });
    await updateFavoriteStatus(widget.book.id!, true);
    Navigator.pop(context, true);
  }
  void _notFavorite() async {
  setState(() {
    widget.book.isFavorite = false;
    widget.favorites.remove(widget.book);
  });
  await updateFavoriteStatus(widget.book.id!, false);
  Navigator.pop(context, true); 
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 235, 244, 100),
      appBar: AppBar(title: Text('${widget.book.title}', style: TextStyle(fontFamily: 'Cinzel',
                      color: Colors.white),),
      backgroundColor: const Color.fromARGB(225, 78, 7, 20),
              actions: [
                  IconButton(
                         onPressed: widget.book.isFavorite ? _notFavorite : _favorite,
                         icon: Icon(
                                widget.book.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: widget.book.isFavorite ? Colors.red : Colors.white,
                                ),
                         iconSize: 30,),
                  IconButton(
                    onPressed: () =>widget.onDeteteBook(widget.book), 
                    icon: Icon(Icons.delete_outline, color: Colors.white,),
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
                      styleFrom(backgroundColor: const Color.fromARGB(225, 78, 7, 20), 
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
