class QuotesModel {
  const QuotesModel({required this.quote, required this.bookTitle});

  final String quote;
  final String bookTitle;
  
  Map<String, String> get quoteDetails
  {
    return 
    {
      'Qoute': quote,
      'Book Title': bookTitle,
    };
  }
}