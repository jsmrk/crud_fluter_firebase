import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_fluter_firebase/services/nickname_service.dart';
import 'package:crud_fluter_firebase/services/concern_service.dart';
import 'package:flutter/material.dart';

class SavingData extends StatefulWidget {
  const SavingData({Key? key}) : super(key: key);

  @override
  State<SavingData> createState() => _SavingDataState();
}

class _SavingDataState extends State<SavingData> {
  final _concern = Concern();
  String _selectedUrgency = 'Low';
  List<String> urgency = ['Low', 'High'];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationusernameController = TextEditingController();

  // This code will return your nickname
  String nickname() {
    return Nickname().readNickname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedUrgency,
            items: urgency.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (item) {
              setState(() {
                _selectedUrgency = item!;
              });
            },
          ),
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
              _concern.addUsername(
                title: titleController.text,
                description: descriptionController.text,
                location: locationusernameController.text,
                urgency: _selectedUrgency,
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
