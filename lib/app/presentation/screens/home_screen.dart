
import 'package:flutter/material.dart';

import 'contacts_list_screen.dart';
import 'local_contacts_list_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('app development'),
          bottom: const TabBar(
            tabs: [
              Tab( text: 'Api Data'),
              Tab(text: 'Local Data'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ContactsListScreen(),
            LocalContactListScreen(),
          ],
        ),
      ),
    );
  }
}