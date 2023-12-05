import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import 'nickname_service.dart';

class Concern {
  int _index = 0;

  Future addUsername({
    required String urgency,
    required String title,
    required String description,
    required String location,
    required List<String> imageURLs,
  }) async {
    // Load the concern index from Hive
    await loadIndex();

    // Add the concern to FirebaseFirestore
    String nickname() {
      return Nickname().readNickname();
    }

    final docUser = FirebaseFirestore.instance
        .collection('nickname')
        .doc(nickname())
        .collection('concern')
        .doc(_index.toString());

    final json = {
      'title': title,
      'description': description,
      'location': location,
      'datetime': DateTime.now(),
      'urgency': urgency,
      'imageURL': imageURLs,
    };
    await docUser.set(json);

    // Increment the index and save it to Hive
    _index++;
    await saveIndex();
  }

  // Load the concern index from Hive
  Future<void> loadIndex() async {
    var box = await Hive.openBox('indexBox');
    if (box.containsKey('index')) {
      _index = box.get('index');
    }
  }

  // Save the concern index to Hive
  Future<void> saveIndex() async {
    var box = await Hive.openBox('indexBox');
    await box.put('index', _index);
  }
}
