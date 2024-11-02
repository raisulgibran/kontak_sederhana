import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kontak_sederhana/main.dart';

void main() {
  testWidgets('Aplikasi berjalan tanpa error', (WidgetTester tester) async {
    // Membangun aplikasi dan memicu satu frame.
    await tester.pumpWidget(MyApp());

    // Periksa bahwa aplikasi tidak memberikan error saat dijalankan.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
