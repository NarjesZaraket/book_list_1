import 'package:book_list_1/data/quotes.dart';
import 'package:book_list_1/models/quotes_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Quotes extends StatelessWidget {
  Quotes({super.key});

  final List<QuotesModel> quotesList = quotes;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 120,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 1.0,
      ),
      items: quotesList.map((quote) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(224, 255, 244, 174),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(66, 204, 153, 153),
                  blurRadius: 4,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      quote.quote,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.w800,
                        color: const Color.fromARGB(225, 78, 7, 20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('- ${quote.bookTitle}',
                           style: TextStyle(
                            fontSize: 15, 
                            fontFamily: 'Cinzel',
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(225, 78, 7, 20),), ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}