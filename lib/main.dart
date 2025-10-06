import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'models/book.dart';
import 'pages/home_page.dart';
import 'pages/add_book_page.dart';
import 'pages/borrow_page.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(const PerpustakaanApp());
}

class PerpustakaanApp extends StatefulWidget {
  const PerpustakaanApp({super.key});

  @override
  State<PerpustakaanApp> createState() => _PerpustakaanAppState();
}

class _PerpustakaanAppState extends State<PerpustakaanApp> {
  int _currentIndex = 0;
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  /// 🔹 Muat data dari SharedPreferences
  Future<void> _loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('books');
    if (data != null) {
      setState(() {
        _books = data.map((e) => Book.fromJson(json.decode(e))).toList();
      });
    } else {
      // Data awal (default)
      _books = [
        Book(title: "Laskar Pelangi", author: "Andrea Hirata", category: "Fiksi"),
        Book(title: "Ensiklopedia Sains", author: "Tim Sains", category: "Sains"),
        Book(title: "Flutter Dasar", author: "Google Dev", category: "Teknologi"),
        Book(title: "Dilan 1990", author: "Pidi Baiq", category: "Fiksi"),
      ];
    }
  }

  /// 🔹 Simpan data ke SharedPreferences
  Future<void> _saveBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _books.map((book) => json.encode(book.toJson())).toList();
    await prefs.setStringList('books', data);
  }

  /// 🔹 Tambahkan buku baru dari AddBookPage
  void _addBook(Book newBook) {
    setState(() {
      _books.add(newBook);
    });
    _saveBooks();
  }

  /// 🔹 Pinjam / kembalikan buku dari HomePage
  void _toggleBorrow(int index) {
    setState(() {
      _books[index].available = !_books[index].available;
    });
    _saveBooks();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(books: _books, onBorrow: _toggleBorrow),
      AddBookPage(onAddBook: _addBook),
      BorrowPage(books: _books, onBorrow: _toggleBorrow),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.blue[200],
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.teal.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("📚 Aplikasi Perpustakaan"),
          backgroundColor: Colors.blue,
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNav(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }
}
