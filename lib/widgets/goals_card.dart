import 'package:book_list_1/models/goals.dart';
import 'package:flutter/material.dart';
import 'package:book_list_1/models/book.dart';
import 'package:book_list_1/screens/book_details.dart';

class GoalsCard extends StatelessWidget {
  const GoalsCard({super.key, required this.goal, required this.currentlyReading,
    required this.favorites,
    required this.onDeteteBook,
  });
  final Goals goal;
  final List<Book> currentlyReading;
  final List<Book> favorites;
  final Function(Book) onDeteteBook;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(224, 255, 244, 174),
      child: InkWell(
        splashColor: const Color.fromARGB(108, 201, 23, 23),
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => BookDetails(
                        book: goal.bookToFinish!,
                        currentlyReading: currentlyReading,
                        favorites: favorites,
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
                Image.asset(
                  genreImage[goal.bookToFinish!.genre]!,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Text(goal.bookToFinish!.title,
                style: TextStyle(
                  color: const Color.fromARGB(224, 24, 43, 37),
                  fontSize: 17,
                ),),
              Spacer(),
              Text('${goal.formattedDate}',
                style: TextStyle(
                  color: const Color.fromARGB(224, 24, 43, 37),
                ),)
              
            ],
          ),
      ),
      ),
    );
  }
}