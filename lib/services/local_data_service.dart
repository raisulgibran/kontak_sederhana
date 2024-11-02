import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/contact.dart';

class LocalDataService {
  final String filePath =
      'assets/data/contacts.json'; // Path awal untuk read-only
  late String _localFilePath; // Path untuk menyimpan data lokal

  LocalDataService() {
    _init(); // Inisialisasi untuk mendapatkan path lokal
  }

  Future<void> _init() async {
    final directory = await getApplicationDocumentsDirectory();
    _localFilePath = '${directory.path}/contacts.json'; // Lokasi file lokal
  }

  Future<List<Contact>> loadContacts() async {
    try {
      final String response = await rootBundle.loadString(filePath);
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Contact.fromJson(json)).toList();
    } catch (e) {
      print("Error loading contacts: $e");
      return []; // Mengembalikan list kosong jika terjadi error
    }
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    final String jsonData =
        json.encode(contacts.map((e) => e.toJson()).toList());
    File file = File(_localFilePath);

    try {
      await file.writeAsString(jsonData);
      print("Data disimpan ke: $_localFilePath");
    } catch (e) {
      print("Error saving contacts: $e");
    }
  }
}
