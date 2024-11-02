// screens/contact_form_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contact_provider.dart';
import '../models/contact.dart';

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;

  ContactFormScreen({this.contact});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Tambah Kontak' : 'Edit Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.contact?.name ?? '',
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: widget.contact?.phoneNumber ?? '',
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newContact = Contact(
                      id: widget.contact?.id ??
                          DateTime.now().millisecondsSinceEpoch,
                      name: _name,
                      phoneNumber: _phoneNumber,
                    );
                    if (widget.contact == null) {
                      Provider.of<ContactProvider>(context, listen: false)
                          .addContact(newContact);
                    } else {
                      Provider.of<ContactProvider>(context, listen: false)
                          .updateContact(newContact);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.contact == null ? 'Tambah' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
