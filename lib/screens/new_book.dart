import 'package:book_list_1/models/book.dart';
import 'package:flutter/material.dart';

class NewBook extends StatefulWidget {
  const NewBook({super.key, required this.addNewBook});
  final Function(Book) addNewBook;

  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _summaryController = TextEditingController();
  Genre _selectedGenre = Genre.fiction;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  void _submitBookForm() {
    if (_titleController.text.trim().isEmpty ||
        _authorController.text.trim().isEmpty ||
        _summaryController.text.trim().isEmpty ) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text(
              "Please make sure you eneter a valid title, author's name, and summary"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Close'),
            )
          ],
        ),
      );
      return;
    }
    Book newBook = Book(
        title: _titleController.text,
        author: _authorController.text,
        summary: _summaryController.text,
        genre: _selectedGenre,
      );
    widget.addNewBook(newBook);
    Navigator.pop(context);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Book')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text("Book Title"),
              ),
            ),
        
            TextField(
              controller: _authorController,
              maxLength: 30,
              decoration: InputDecoration(
                label: Text("Author's Name"),
              ),
            ),

            TextField(
              controller: _summaryController,
              maxLength: 100,
              decoration: InputDecoration(
                label: Text("Add A Summary"),
              ),
            ),

            DropdownButton(
                    value: _selectedGenre,
                    items: Genre.values.map((genre) => DropdownMenuItem(
                                  value: genre,
                                  child: Text(genre.name.toUpperCase())),).toList(), 
                    onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedGenre = value;
                          });
                        },
                    isExpanded: true, 
                    ),

            Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: (){Navigator.pop(context);},
                  style: ElevatedButton.
                          styleFrom(backgroundColor: Colors.black, 
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),), 
                  child: Text('cancel')
                  ),

                Spacer(),

                ElevatedButton(
                  onPressed: _submitBookForm, 
                  style: ElevatedButton.
                          styleFrom(backgroundColor: Colors.black, 
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  child: Text('save')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
