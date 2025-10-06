import 'package:flutter/material.dart';
import '../models/book.dart';

class AddBookPage extends StatefulWidget {
  final Function(Book) onAddBook;

  const AddBookPage({super.key, required this.onAddBook});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _categoryController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newBook = Book(
        title: _titleController.text,
        author: _authorController.text,
        category: _categoryController.text,
      );
      widget.onAddBook(newBook);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Buku berhasil ditambahkan!")),
      );
      _titleController.clear();
      _authorController.clear();
      _categoryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Judul Buku"),
              validator: (value) =>
                  value == null || value.isEmpty ? "Judul tidak boleh kosong" : null,
            ),
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: "Penulis"),
              validator: (value) => value == null || value.length < 3
                  ? "Nama penulis minimal 3 karakter"
                  : null,
            ),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: "Kategori"),
              validator: (value) =>
                  value == null || value.isEmpty ? "Kategori wajib diisi" : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Tambah Buku"),
            ),
          ],
        ),
      ),
    );
  }
}
