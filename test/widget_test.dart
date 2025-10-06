// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts/main.dart';

void main() {
  testWidgets('HomePage menampilkan daftar buku', (WidgetTester tester) async {
    await tester.pumpWidget(const PerpustakaanApp());

    // Pastikan judul halaman tampil
    expect(find.text('📚 Daftar Buku'), findsOneWidget);

    // Pastikan beberapa judul buku dari data awal tampil
    expect(find.text('Laskar Pelangi'), findsOneWidget);
    expect(find.text('Ensiklopedia Sains'), findsOneWidget);
    expect(find.text('Flutter Dasar'), findsOneWidget);
    expect(find.text('Dilan 1990'), findsOneWidget);

    // Pastikan widget pencarian tampil
    expect(find.byType(TextField), findsOneWidget);
  });
}
