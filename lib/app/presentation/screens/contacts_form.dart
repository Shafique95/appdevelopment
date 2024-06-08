import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/contacts_controller.dart';

class ContactForm extends StatelessWidget {
    ContactForm({super.key});
   ContactsController contactsController=Get.put(ContactsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             TextField(
              controller: contactsController.nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
             TextField(
              controller: contactsController.phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                contactsController.submitContact(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
