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
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    contactsController.submitContact(context);
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () async{
                   await contactsController.saveContactToSqlite(context);
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Save contact to local database')),
                   );
                  },
                  child: const Text('Save to Local'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
