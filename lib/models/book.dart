class Book {
  String title;
  String author;
  String category;
  bool available;
  String? borrower; // nama peminjam (opsional)
  String? email; // email peminjam

  Book({
    required this.title,
    required this.author,
    required this.category,
    this.available = true,
    this.borrower,
    this.email,
  });

  // konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'category': category,
      'available': available,
      'borrower': borrower,
      'email': email,
    };
  }

  // dari JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      category: json['category'],
      available: json['available'],
      borrower: json['borrower'],
      email: json['email'],
    );
  }
}
