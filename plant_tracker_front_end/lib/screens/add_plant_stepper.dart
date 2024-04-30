import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_tracker/widgets/bottom_bar.dart';
import 'package:plant_tracker/widgets/carousel.dart';
import 'package:plant_tracker/widgets/featured_heading.dart';
import 'package:plant_tracker/widgets/featured_tiles.dart';
import 'package:plant_tracker/widgets/floating_quick_access_bar.dart';
import 'package:plant_tracker/widgets/main_heading.dart';
import 'package:plant_tracker/widgets/menu_drawer.dart';
import 'package:plant_tracker/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_tracker/data/plant_tracker.dart';



class AddPlantPage extends StatefulWidget {
  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;
  String _imagePath = '';

  File? _image;
  final picker = ImagePicker();
  Uint8List webImage = Uint8List(8);
  // Initial Selected Value 
  
  // List of items in our dropdown menu 
   final Map<int, String> dropdownItems = {
    3: 'TROPICAL PLANTS',
    4: 'MOSS',
    5: 'AQUATIC PLANTS',
    6: 'EPIFIED PLANTS',
    // Add more key-value pairs as needed
  };

  int? _dropdownvalue = 3; 


  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Future<void> getImage() async {

    if(!kIsWeb){

      final ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        _image = File(pickedImage.path);
        setState(() {
           _imagePath = _image!.path;
        });
      } else {
        print('No image selected.');
      }

    }else if(kIsWeb){
      final ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
       var f = await pickedImage.readAsBytes();
       setState(() {
         webImage = f;
          _image = File(pickedImage.path);
          _imagePath =_image!.path;
       });
      } else {
        print('No image selected.');
      }
    }
    
  }
  void _savePlant() async{
    // Here you can implement the logic to save the plant data to the database
    // For demonstration purposes, we'll simply print the plant data
    print('Common Name: $_commonName');
    print('Scientific Name: $_scientificName');
    print('Family: $_family');
    print('Description: $_description');
    //print('Care Instructions: $_careInstructions');
    print('Origin: $_origin');
    print('Lighting Condition: $_lightingCondition');
    print('Substrate: $_substrate');
    print('Growing Speed: $_growingSpeed');
    print('Image path: $_imagePath');
    // After saving, you can navigate back to the previous screen or any other screen
    final newPlantTracker = PlantTracker(
                              common_name: _commonName,
                              scientific_name: _scientificName,
                              family: _family,
                              description: _description,
                              //care_instructions: _careInstructions,
                              photo_url: _imagePath,
                              origin: _origin,
                              lighting_condition: _lightingCondition,
                              substrate: _substrate,
                              growing_speed: _growingSpeed,
                              category_id: _dropdownvalue,
                            );

    final createdTodoResponse = await createPlant(newPlantTracker);

    Navigator.pop(context);
  }

  int currentStep = 0;
  bool isCompleted = false;

  // final _commonName = TextEditingController();
  // final _family = TextEditingController();
  // final _description = TextEditingController();
  // final _scientificName = TextEditingController();

  String _commonName = '';
  String _scientificName = '';
  String _family = '';
  String _description = '';
  String _origin = '';
  String _lightingCondition = '';
  String _substrate = '';
  String _growingSpeed = '';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: screenSize.width < 800
          ? AppBar(
              backgroundColor:
                  Color.fromARGB(255, 228, 229, 230).withOpacity(_opacity),
              title: Text(
                'Plant Tracker',
                style: TextStyle(
                  color: Color(0xFF077bd7),
                  fontSize: 26,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Color(0xFF077bd7),
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 70),
              child: TopBarContents(_opacity),
            ),
      drawer: screenSize.width < 800 ? MenuDrawer() : null,
      body: isCompleted
          ? buildCompleted()
          : Padding(
              padding: screenSize.width < 800
                  ? EdgeInsets.all(10.0)
                  : const EdgeInsets.all(100.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                      primary: Color.fromARGB(255, 40, 135, 65)),
                ),
                child: Stepper(
                  type: screenSize.width < 800
                      ? StepperType.vertical
                      : StepperType.horizontal,
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;

                    if (isLastStep) {
                      setState(() => isCompleted = true);
                      print('Completed');
                      _savePlant();

                      /// send data to server
                    } else {
                      setState(() => currentStep += 1);
                    }
                  },
                  onStepTapped: (step) => setState(() => currentStep = step),
                  onStepCancel: currentStep == 0
                      ? null
                      : () => setState(() => currentStep -= 1),
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controlsDetails) {
                    final isLastStep = currentStep == getSteps().length - 1;

                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                              onPressed: controlsDetails.onStepContinue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (currentStep != 0)
                            Expanded(
                              child: ElevatedButton(
                                child: Text('BACK'),
                                onPressed: controlsDetails.onStepCancel,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Basic Information'),
          content: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 300, // Adjust the width as needed
                    height: 300, // Adjust the height as needed
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1, // Border width
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      child: _image == null
                      ?
                      TextButton.icon(
                        onPressed: getImage, 
                        icon: const Icon(Icons.camera), 
                        label: const Text('Select Picture'),
                      )
                      : kIsWeb?
                         Image.memory(webImage,fit: BoxFit.fill):
                         Image.file(_image!,fit: BoxFit.fill,),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      constraints: BoxConstraints(
                        minWidth: 13,
                        minHeight: 13,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                alignment: Alignment.centerLeft,
                child: DropdownButton<int>(
                    value: _dropdownvalue, // Initially selected value
                    onChanged: (int? newValue) {
                      // Handle dropdown value changes
                      if (newValue != null) {
                        setState(() {
                          _dropdownvalue = newValue!;
                          print('drop down value ${_dropdownvalue}');
                        });
                      }
                    },
                    items: dropdownItems.entries.map((MapEntry<int, String> entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
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
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Care Instructions'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Origin'),
                onChanged: (value) {
                  setState(() {
                    _origin = value;
                  });
                },
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lighting Condition',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Radio<String>(
                        value: 'Low',
                        groupValue: _lightingCondition,
                        onChanged: (value) {
                          setState(() {
                            _lightingCondition = value!;
                          });
                        },
                      ),
                      Text('Low'),
                      Radio<String>(
                        value: 'Medium',
                        groupValue: _lightingCondition,
                        onChanged: (value) {
                          setState(() {
                            _lightingCondition = value!;
                          });
                        },
                      ),
                      Text('Medium'),
                      Radio<String>(
                        value: 'High',
                        groupValue: _lightingCondition,
                        onChanged: (value) {
                          setState(() {
                            _lightingCondition = value!;
                          });
                        },
                      ),
                      Text('High'),
                    ],
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Substrate'),
                onChanged: (value) {
                  setState(() {
                    _substrate = value;
                  });
                },
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Growing Speed',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Radio<String>(
                        value: 'Slow',
                        groupValue: _growingSpeed,
                        onChanged: (value) {
                          setState(() {
                            _growingSpeed = value!;
                          });
                        },
                      ),
                      Text('Slow'),
                      Radio<String>(
                        value: 'Medium',
                        groupValue: _growingSpeed,
                        onChanged: (value) {
                          setState(() {
                            _growingSpeed = value!;
                          });
                        },
                      ),
                      Text('Medium'),
                      Radio<String>(
                        value: 'Fast',
                        groupValue: _growingSpeed,
                        onChanged: (value) {
                          setState(() {
                            _growingSpeed = value!;
                          });
                        },
                      ),
                      Text('Fast'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text('Review & Submit'),
          content: Column(
            children: <Widget>[
              Container(
                width: 300, // Adjust the width as needed
                height: 300, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                      child: _image == null
                      ?
                      TextButton.icon(
                        onPressed: getImage, 
                        icon: const Icon(Icons.camera), 
                        label: const Text('Select Picture'),
                      )
                      : kIsWeb?
                         Image.memory(webImage,fit: BoxFit.fill):
                         Image.file(_image!,fit: BoxFit.fill,),
                    ),
                  // Image(
                  //   image: AssetImage('assets/images/background.png'),
                  //   fit: BoxFit.cover, // Adjust the fit as needed
                  // ),
                ),
              ),
              const SizedBox(height: 12),
              buildText('Category', dropdownItems[_dropdownvalue]!),
              const SizedBox(height: 12),
              buildText('Common Name', _commonName),
              const SizedBox(height: 12),
              buildText('Family', _family),
              const SizedBox(height: 12),
              buildText('Description', _description),
              const SizedBox(height: 12),
              buildText('Scientific Name', _scientificName),
              const SizedBox(height: 12),
              buildText('Origin', _origin),
              const SizedBox(height: 12),
              buildText('Lighting Condition', _lightingCondition),
              const SizedBox(height: 12),
              buildText('Substrate', _substrate),
              const SizedBox(height: 12),
              buildText('Growing Speed', _growingSpeed),
            ],
          ),
        ),
      ];

  Widget buildCompleted() => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 52),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_done, color: Colors.blue, size: 120),
            const SizedBox(height: 8),
            Text(
              'Success',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 64),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(fontSize: 24),
                minimumSize: Size.fromHeight(50),
              ),
              child: Text('Reset'),
              onPressed: () => setState(() {
                isCompleted = false;
                currentStep = 0;

                // _commonName.clear();
                // _family.clear();
                // _description.clear();
                // _scientificName.clear();
              }),
            ),
          ],
        ),
      );

  Widget buildText(String title, String value) => Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200], // Adjust color to match the theme
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: const Color.fromARGB(255, 204, 204, 204)), // Border color
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.done_sharp, // You can change the icon based on the item
              color: Colors.green, // Adjust color to match the theme
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green, // Adjust color to match the theme
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87, // Adjust color to match the theme
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
