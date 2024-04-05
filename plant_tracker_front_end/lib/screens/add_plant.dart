import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPlantScreen extends StatefulWidget {
  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();

  String _commonName = '';
  String _scientificName = '';
  String _family = '';
  String _description = '';
  String _careInstructions = '';
  String _origin = '';
  String _lightingCondition = '';
  String _substrate = '';
  String _growingSpeed = '';

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Plant'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _image == null
                      ? ElevatedButton(
                          onPressed: getImage,
                          child: Icon(Icons.add_a_photo),
                        )
                      : SizedBox(
                          height: 200,
                          child: Image.file(_image!),
                        ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Common Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the common name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _commonName = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Scientific Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the scientific name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _scientificName = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Family'),
                    onChanged: (value) {
                      setState(() {
                        _family = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Care Instructions'),
                    onChanged: (value) {
                      setState(() {
                        _careInstructions = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Origin'),
                    onChanged: (value) {
                      setState(() {
                        _origin = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Lighting Condition'),
                    onChanged: (value) {
                      setState(() {
                        _lightingCondition = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Substrate'),
                    onChanged: (value) {
                      setState(() {
                        _substrate = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Growing Speed'),
                    onChanged: (value) {
                      setState(() {
                        _growingSpeed = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, save the plant data
                        _savePlant();
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _savePlant() {
    // Here you can implement the logic to save the plant data to the database
    // For demonstration purposes, we'll simply print the plant data
    print('Common Name: $_commonName');
    print('Scientific Name: $_scientificName');
    print('Family: $_family');
    print('Description: $_description');
    print('Care Instructions: $_careInstructions');
    print('Origin: $_origin');
    print('Lighting Condition: $_lightingCondition');
    print('Substrate: $_substrate');
    print('Growing Speed: $_growingSpeed');
    // After saving, you can navigate back to the previous screen or any other screen
    Navigator.pop(context);
  }
}
