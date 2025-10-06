import 'package:flutter/material.dart';
import '../models/book.dart';

class HomePage extends StatelessWidget {
  final List<Book> books;
  final Function(int) onBorrow;

  const HomePage({super.key, required this.books, required this.onBorrow});

  @override
  Widget build(BuildContext context) {
    // Grouping buku berdasarkan kategori
    final Map<String, List<Book>> categorizedBooks = {};
    for (var book in books) {
      categorizedBooks.putIfAbsent(book.category, () => []);
      categorizedBooks[book.category]!.add(book);
    }

    return Container(
      color: Colors.grey[100],
      child: ListView(
        children: categorizedBooks.entries.map((entry) {
          String category = entry.key;
          List<Book> categoryBooks = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul kategori
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),

              // Daftar buku dalam kategori
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryBooks.length,
                itemBuilder: (context, index) {
                  final book = categoryBooks[index];
                  final globalIndex = books.indexOf(book);

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.book, color: Colors.blueAccent),
                      title: Text(
                        book.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(book.author),
                      trailing: Text(
                        book.available ? "Tersedia" : "Dipinjam",
                        style: TextStyle(
                          color: book.available ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        onBorrow(globalIndex);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(book.available
                                ? "Buku dikembalikan: ${book.title}"
                                : "Buku dipinjam: ${book.title}"),
                            backgroundColor:
                                book.available ? Colors.green : Colors.red,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
