import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/contacts_model.dart';
import '../../repository/local_repository/contact_local_repo.dart';
import '../../repository/remote_repository/api_repository.dart';

class ContactsController extends GetxController{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final contacts = <Contact>[].obs;
  final localDatabaseContactList = <Contact>[].obs;
  final _apiRepository=ApiRepository();
  final _contactRepository=ContactRepository();
  @override
  void onInit() {
    super.onInit();
    fetchContacts();
    fetchContactsFromSqlite();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  void submitContact(context) async {
    final name = nameController.text;
    final phone = phoneController.text;
    try {
      final responseCode = await _apiRepository.addContact(name: name, phoneNumber: phone);
      if (responseCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contact added successfully')),
        );
        Navigator.pop(context);
        nameController.clear();
        phoneController.clear();
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add contact: $e')),
      );
    }
  }
  Future<void> fetchContacts() async {
    try {
      final fetchedContacts = await _apiRepository.getContacts();
      contacts.assignAll(fetchedContacts);
    } catch (e) {
      // Handle error
      print('Failed to fetch contacts: $e');
    }
  }
 Future<void> saveContactToSqlite(context) async{
    final name = nameController.text;
    final phone = phoneController.text;
    if(name.isEmpty && phone.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name or Phone may be empty')),
      );
    }else{
      Contact contact=Contact(id: 1, name: name, phone: phone);
      await _contactRepository.saveContact(contact);
      Navigator.pop(context);
      nameController.clear();
      phoneController.clear();
    }
  }
  Future<void> fetchContactsFromSqlite() async {
    try {
      final fetchedContacts = await _contactRepository.getContacts();
      localDatabaseContactList.assignAll(fetchedContacts);
    } catch (e) {
      print('Failed to fetch contacts: $e');
    }
  }

}