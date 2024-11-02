import 'package:flutter/material.dart';
import 'models/contact.dart';
import 'services/local_data_service.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  final LocalDataService _dataService = LocalDataService();

  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    _contacts = await _dataService.loadContacts();
    notifyListeners();
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
    _dataService.saveContacts(_contacts);
  }

  void updateContact(Contact contact) {
    int index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _contacts[index] = contact;
      notifyListeners();
      _dataService.saveContacts(_contacts);
    }
  }

  void deleteContact(int id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
    _dataService.saveContacts(_contacts);
  }
}
