import 'package:cloud_firestore/cloud_firestore.dart';

import 'nickname_service.dart';

class Concern {
  int index = 0;

  Future addUsername({required String name}) async {
    String nickname() {
      return Nickname().readNickname();
    }

    final docUser = FirebaseFirestore.instance
        .collection('nickname')
        .doc(nickname())
        .collection('concern')
        .doc(index.toString());

    final json = {
      'name': name,
      'age': 23,
      'birtday': DateTime.now(),
    };
    await docUser.set(json);

    index++; // Increment the index
  }
}
