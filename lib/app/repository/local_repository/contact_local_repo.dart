import 'package:sqflite/sqflite.dart';

import '../../db_helper/database_helper.dart';
import '../../models/contacts_model.dart';

class ContactRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Future<void> saveContact(Contact contact) async {
    final Database db = await _databaseHelper.database;
    var batch = db.batch();
    try {
      batch.insert(
        'contacts',
        contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await batch.commit(noResult: true);
    } catch (e) {
      throw "Error occurred while saving contact: $e";
    }
  }

  Future<List<Contact>> getContacts() async {
    final Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM contacts');
    List<Contact> contacts = [];
    for (var map in result) {
      contacts.add(
        Contact(
          id: map['id'],
          name: map['name'],
          phone: map['phone'],
        ),
      );
    }
    return contacts;
  }
}
