import 'package:book_list_1/models/goals.dart';
import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/screens/book_details.dart';

class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key, required this.goal, required this.currentlyReading,
                    required this.favorite, required this.onDeteteBook});
  final Goals goal;
  final List<Book> currentlyReading;
  final List<Book> favorite;
  final Function(Book) onDeteteBook;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: const Color.fromARGB(108, 201, 23, 23),
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => BookDetails(
                        book: goal.bookToFinish,
                        currentlyReading: currentlyReading,
                        favorite: favorite,
                        onDeteteBook: onDeteteBook,
                      )
              )
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              ClipRRect( 
                borderRadius: BorderRadius.circular(16),
                child:              
                Image.asset(genreImage[goal.bookToFinish.genre]!, height: 80, fit: BoxFit.cover),
              ),
              SizedBox(width: 10),
              Text(goal.bookToFinish.title),
              Spacer(),
              Text('${goal.formattedDate}')
              
            ],
          ),
      ),
      ),
    );
  }
}