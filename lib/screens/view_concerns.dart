import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_fluter_firebase/services/saving_concern_service.dart';
import 'package:flutter/material.dart';

import '../models/concern_model.dart';
import '../services/nickname_service.dart';

class ViewConcerns extends StatelessWidget {
  ViewConcerns({super.key});

  String nickname() {
    return Nickname().readNickname();
  }

  Stream<List<Concern>> readConcerns() {
    return FirebaseFirestore.instance
        .collection('nickname')
        .doc(nickname())
        .collection('concern')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              final timestamp = data['datetime'];
              final dateTime = timestamp.toDate();

              List<String>? imageURLs;
              try {
                // Check for null or non-list value
                imageURLs = (data['imageURL'] as List).cast<String>();
              } catch (error) {
                print('Error retrieving image URLs: $error');
              }

              final concern = Concern(
                imageURLs: imageURLs,
                urgency: data['urgency'],
                title: data['title'],
                description: data['description'],
                location: data['location'],
                dateTime: dateTime,
              );
              return concern;
            }).toList());
  }

  Widget buildConcern(Concern concern) {
    // Use the existing code to display concern details
    return Container(
      margin: const EdgeInsets.all(31),
      alignment: Alignment.center,
      child: Column(
        children: [
          for (final imageUrl in concern.imageURLs!) Image.network(imageUrl),
          Text(concern.urgency),
          Text(concern.title),
          Text(concern.description),
          Text(concern.location),
          Text(concern.dateTime.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Concern>>(
        stream: readConcerns(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Erorroreroeroeoreoroeroe herere:::::::');
            print(snapshot.error);
            print('Erorroreroeroeoreoroeroe herere:::::::');
            return const Text('An error occured!');
          } else if (snapshot.hasData) {
            final concerns = snapshot.data!; // Use plural 'concerns'
            if (concerns.isEmpty) {
              return const Center(child: Text('No concerns found'));
            } else {
              return ListView(
                children:
                    concerns.map((concern) => buildConcern(concern)).toList(),
              );
            }
          } else {
            // Add a loading widget while waiting for data
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
