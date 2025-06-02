import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/screens/book_details.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book, required this.currentlyReading,
    required this.favorites,
    required this.onDeteteBook,
    required this.onBookUpdate
  });
  final Book book;
  final List<Book> currentlyReading;
  final List<Book> favorites;
  final Function(Book) onDeteteBook;
  final Function() onBookUpdate;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(224, 255, 244, 174),
      child: InkWell(
        splashColor: const Color.fromARGB(108, 201, 23, 23),
        borderRadius: BorderRadius.circular(50),
        onTap: () { final result =
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => BookDetails(
                        book: book,
                        currentlyReading: currentlyReading,
                        favorites: favorites,
                        onDeteteBook: onDeteteBook,
                      )
              )
          );
          if(result == true)
          {onBookUpdate;}
          
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              ClipRRect( 
                borderRadius: BorderRadius.circular(16),
                child:              
                Image.asset(genreImage[book.genre]!, height: 200, fit: BoxFit.cover),
              ),
              SizedBox(height: 10),
              Text(book.title, style: TextStyle(color: const Color.fromARGB(225, 78, 7, 20),
                    ),)
            ],
          ),
      ),
      ),
    );
  }
}