import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_fluter_firebase/services/nickname_service.dart';
import 'package:crud_fluter_firebase/services/concern_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  List<File> selectedImages = []; // List of selected image
  final picker = ImagePicker(); // Instance of Image picker

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
        maxHeight: 1000, // To set maxheight of images that you want in your app
        maxWidth: 1000); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;

    // if atleast 1 images is selected it will add
    // all images in selectedImages
    // variable so that we can easily show them in UI
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      setState(
        () {},
      );
    } else {
      // If no image is selected it will show a
      // snackbar saying nothing is selected
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }

  void _showImageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take Photo'),
                  onTap: () {
                    // Navigator.of(context).pop();
                    // _pickImageFromCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImages();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
            onPressed: () async {
              List<String> downloadURLs = [];
              for (int index = 0; index < selectedImages.length; index++) {
                final storageRef = FirebaseStorage.instance.ref(
                    'images/${selectedImages[index].path.split('/').last}');
                final uploadTask = storageRef.putFile(selectedImages[index]);
                final snapshot = await uploadTask.whenComplete(() => null);
                final downloadURL = await storageRef.getDownloadURL();
                downloadURLs.add(downloadURL);
              }

              // Add the concern with download URLs
              _concern.addUsername(
                title: titleController.text,
                description: descriptionController.text,
                location: locationusernameController.text,
                urgency: _selectedUrgency,
                imageURLs: downloadURLs,
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: getImages,
            icon: Icon(Icons.add_photo_alternate),
          ),
          Expanded(
            child: SizedBox(
              width: 300.0, // To show images in particular area only
              child: selectedImages.isEmpty // If no images is selected
                  ? const Center(child: Text('Sorry nothing selected!!'))
                  // If atleast 1 images is selected
                  : GridView.builder(
                      itemCount: selectedImages.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3
                              // Horizontally only 3 images will show
                              ),
                      itemBuilder: (BuildContext context, int index) {
                        // TO show selected file
                        return Center(
                            child: kIsWeb
                                ? Image.network(selectedImages[index].path)
                                : Image.file(selectedImages[index]));
                        // If you are making the web app then you have to
                        // use image provider as network image or in
                        // android or iOS it will as file only
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
