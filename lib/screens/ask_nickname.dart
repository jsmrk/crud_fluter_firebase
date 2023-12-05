import 'package:crud_fluter_firebase/services/nickname_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'saving_data.dart';

// This will ask for a name will be use as an ID in firebase database
// I will use hive to save the nickname locally

class AskingNickname extends StatelessWidget {
  final nicknameController = TextEditingController();
  final nickname = Nickname();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 255, left: 35, right: 35),
        child: Column(
          children: [
            TextField(
              controller: nicknameController,
            ),
            ElevatedButton(
                onPressed: () =>
                    nickname.writeNickname(nicknameController.text),
                child: Text('save')),
            ElevatedButton(
                onPressed: nickname.readNickname, child: Text('read')),
            Text(nickname.readNickname()),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SavingData()),
                  );
                },
                child: Text('go')),
          ],
        ),
      ),
    );
  }
}
