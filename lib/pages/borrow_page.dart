import 'package:flutter/material.dart';
import '../models/book.dart';

class BorrowPage extends StatelessWidget {
  final List<Book> books;
  final Function(int) onBorrow;

  const BorrowPage({super.key, required this.books, required this.onBorrow});

  @override
  Widget build(BuildContext context) {
    final borrowedBooks =
        books.where((book) => book.available == false).toList();

    if (borrowedBooks.isEmpty) {
      return const Center(
        child: Text("Belum ada buku yang dipinjam"),
      );
    }

    return ListView.builder(
      itemCount: borrowedBooks.length,
      itemBuilder: (context, index) {
        final book = borrowedBooks[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: const Icon(Icons.library_books, color: Colors.red),
            title: Text(book.title),
            subtitle: Text("Dipinjam oleh: ${book.author}"),
            trailing: const Text(
              "Dipinjam",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
