// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_provider.dart';
import 'screens/contact_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactProvider()..loadContacts(),
      child: MaterialApp(
        title: 'Kontak Sederhana',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactListScreen(),
      ),
    );
  }
}
