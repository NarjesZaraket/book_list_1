enum Genre {fiction, horror, sciFic, historical, mystery, romance}

const genreName = {
  'Fiction': Genre.fiction,
  'Horror': Genre.horror,
  'Science Fiction': Genre.sciFic,
  'Historical': Genre.historical,
  'Mystery': Genre.mystery,
  'Romance': Genre.romance
};
const genreImage = {
  Genre.sciFic : 'assets/images/scific.jpg',
  Genre.fiction: 'assets/images/fiction.jpg',
  Genre.romance: 'assets/images/romance.jpg',
  Genre.historical: 'assets/images/history.jpg',
  Genre.horror: 'assets/images/horror.jpg',
  Genre.mystery: 'assets/images/mystery.jpg',
};

class Book {
  Book({required this.title, required this.author, required this.genre, required this.summary, 
        this.isReading = false, this.isFavorite = false});

  final String title;
  final String author;
  final String summary;
  final Genre genre;
  bool isReading;
  bool isFavorite;


  Map<String, Object> get bookDetails
  {
    return 
    {
      'title': title,
      'author': author,
      'genre': genre,
      'summary': summary,
      'isReading': isReading ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}