import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive_db/app/data/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController ageEditingController = TextEditingController();
  File? _imageFile;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _addPerson() async {
    // Convert image file to Uint8List
    Uint8List? imageBytes;
    if (_imageFile != null) {
      imageBytes = await _imageFile!.readAsBytes();
    }

    // Create Person object and add to Hive
    final person = Person(
      name: nameEditingController.text,
      age: int.parse(ageEditingController.text),
      imageBytes: imageBytes,
    );

    final hiveBox = await Hive.openBox<Person>('persons');
    hiveBox.add(person);

    // Clear controllers and reset image file
    nameEditingController.clear();
    ageEditingController.clear();
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameEditingController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _getImage,
              child: const Icon(Icons.image_search),
            ),
            const SizedBox(height: 20),
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : Container(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPerson,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
