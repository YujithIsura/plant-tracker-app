import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:plant_tracker/widgets/responsive.dart';
import 'package:flutter/material.dart';

class MainCarousel extends StatefulWidget {
  @override
  _MainCarouselState createState() => _MainCarouselState();
}

class _MainCarouselState extends State<MainCarousel> {
  final List<List<String>> allImages = [
    [
      'assets/images/tropical_plants/AGLEIL.jpg',
      'assets/images/tropical_plants/AGLKRE.jpg',
      'assets/images/tropical_plants/AGLNIG.jpg',
      'assets/images/tropical_plants/AGLEIL.jpg',
      'assets/images/tropical_plants/AGLSIAAUR.jpg',
      'assets/images/tropical_plants/AGLTOT.jpg',
    ],
    [
       'assets/images/aquatic_plants/rotala_green.jpg',
      'assets/images/aquatic_plants/rotala-rotundifolia-singapore-blood-red.jpg',
      'assets/images/aquatic_plants/valisnaria.jpg',
      'assets/images/aquatic_plants/anubias.jpg',
      'assets/images/aquatic_plants/java-fern.jpg',
      'assets/images/aquatic_plants/bucephalandra.jpg',
    ],
    [
      'assets/images/epified_plants/Alamy.jpg',
      'assets/images/epified_plants/AirPlant.jpg',
      'assets/images/epified_plants/birdplant.jpg',
      'assets/images/epified_plants/bromilia.jpg',
      'assets/images/epified_plants/Britanica.jpg',
      'assets/images/epified_plants/bucephalandra-pygmaea.jpg',
    ],
    [
       'assets/images/moss/riccardia-chamedryfolia.jpg',
      'assets/images/moss/Java-moss.jpg',
      'assets/images/moss/FlameMoss.jpg',
      'assets/images/moss/Mini_pelia.jpg',
      'assets/images/moss/Peacock-Moss.jpg',
      'assets/images/moss/pearl.jpg',
    ],
  ];

  final List<List<String>> imageInfo = [
    ['Aglaonema', 'Kresna', 'Alocasia','Polly', 'Asia Alocasia', 'Philo'],
    ['Rotala Green', 'Rotala Blood Red', 'Valisnaria Nana', 'Anubias Nana', 'Java Fern', 'Bucephalandra'],
    ['Alamy', 'Air Plant', 'Bird Nest','Bromilia', 'Britanica', 'Bucephalandra Pygmaea'],
    ['Riccardia Chamedryfolia', 'Java Moss', 'Flame Moss','Mini Pelia', 'Pearl', 'Asia Moss'],
  ];

  final List<String> places = [
    'TROPICAL PLANTS',
    'AQUATIC PLANTS',
    'EPIFIED PLANTS',
    'MOSS',
  ];

  int _current = 0;

  List<Widget> generateImageTiles(int index) {
    List<Widget> imageTiles = [];

    for (int i = 0; i < allImages[index].length; i += 2) {
      imageTiles.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int j = i; j < i + 3 && j < allImages[index].length; j++)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          allImages[index][j],
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        imageInfo[index][j],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Some information about the image...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return imageTiles;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(_current);

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: screenSize.height / 8,
          ),
          child: Column(
            children: imageSliders,
          ),
        ),
        AspectRatio(
          aspectRatio: 17 / 8,
          child: Center(
            heightFactor: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width / 8,
                  right: screenSize.width / 8,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height / 50,
                      bottom: screenSize.height / 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < places.length; i++)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _current = i;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: screenSize.height / 80,
                                    bottom: screenSize.height / 90,
                                  ),
                                  child: Text(
                                    places[i],
                                    style: TextStyle(
                                      color: _current == i
                                          ? Colors.blueGrey[900]
                                          : Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

