import 'package:app_development/app/presentation/screens/contacts_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/contacts_controller.dart';

class ContactsListScreen extends StatelessWidget {
  ContactsListScreen({super.key});
  ContactsController contactsController = Get.put(ContactsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        centerTitle: true,
      ),
      body: Obx(() {
        var contactList = contactsController.contacts.value;
        if (contactList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(contactList[index].name),
                  subtitle: Text(contactList[index].phone),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ContactForm(),
            ),
          ).then((v) async{
            await contactsController.fetchContacts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
