import 'package:app_development/app/presentation/screens/contacts_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/contacts_controller.dart';

class LocalContactListScreen extends StatelessWidget {
  LocalContactListScreen({super.key});
  ContactsController contactsController = Get.put(ContactsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          var contactList = contactsController.localDatabaseContactList.value;
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
              },
            );
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactForm(),
                ),
              ).then((v) async {
                await contactsController.fetchContactsFromSqlite();
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
