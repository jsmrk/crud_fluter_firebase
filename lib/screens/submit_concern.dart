import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_fluter_firebase/services/nickname_service.dart';
import 'package:crud_fluter_firebase/services/concern_service.dart';
import 'package:flutter/material.dart';

class SavingData extends StatelessWidget {
  final _concern = Concern();
  SavingData({super.key});

// This code will return your nickname
  String nickname() {
    return Nickname().readNickname();
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final locationusernameController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
          ),
          TextField(
            controller: locationusernameController,
            decoration: const InputDecoration(hintText: 'Location'),
          ),
          IconButton(
            onPressed: () {
              // final String username = usernameController.text;
              _concern.addUsername(
                  title: titleController.text,
                  description: descriptionController.text,
                  location: locationusernameController.text);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
