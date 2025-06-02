enum Genre {fiction, horror, sciFic, historical, mystery, romance}

const genreName = {
  'fiction': Genre.fiction,
  'horror': Genre.horror,
  'sciFic': Genre.sciFic,
  'historical': Genre.historical,
  'mystery': Genre.mystery,
  'romance': Genre.romance
};
const genreToName ={
  Genre.fiction: 'finction',
  Genre.horror: 'horror',
  Genre.sciFic: 'sciFic',
  Genre.historical: 'historical',
  Genre.mystery: 'mystery',
  Genre.romance: 'romance'
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
  Book({this.id, required this.title, required this.author, required this.genre, required this.summary, 
        this.isReading = false, this.isFavorite = false});

  final String title;
  final String author;
  final String summary;
  final Genre genre;
  bool isReading;
  bool isFavorite;
  final int? id;


  Map<String, Object> get bookDetails
  {
    return 
    {
      'title': title,
      'author': author,
      'genre': genre.toString().split('.').last,
      'summary': summary,
      'isReading': isReading ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      genre: Genre.values.firstWhere(
      (g) => g.name == map['genre'],
      orElse: () => Genre.fiction, // fallback to default if needed
    ),
      summary: map['summary'] as String,
      isReading: (map['isReading'] ?? 0) == 1,
      isFavorite: (map['isFavorite'] ?? 0) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'summary': summary,
      'genre': genre.toString().split('.').last,
      'isReading': isReading ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0, 
    };
  }
}