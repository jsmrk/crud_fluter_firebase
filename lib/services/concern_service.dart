import 'package:cloud_firestore/cloud_firestore.dart';

import 'nickname_service.dart';

class Concern {
  int index = 0;

  Future addUsername(
      {required String title,
      required String description,
      required String location}) async {
    String nickname() {
      return Nickname().readNickname();
    }

    final docUser = FirebaseFirestore.instance
        .collection('nickname')
        .doc(nickname())
        .collection('concern')
        .doc(index.toString());

    final json = {
      'title': title,
      'description': description,
      'location': location,
      'datetime': DateTime.now(),
    };
    await docUser.set(json);

    index++; // Increment the index
  }
}
