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
    final usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: usernameController),
        actions: [
          IconButton(
            onPressed: () {
              final String username = usernameController.text;
              _concern.addUsername(name: username);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Text(nickname()),
    );
  }
}
