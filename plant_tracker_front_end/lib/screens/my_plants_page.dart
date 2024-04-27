import 'package:plant_tracker/widgets/bottom_bar.dart';
import 'package:plant_tracker/widgets/carousel.dart';
import 'package:plant_tracker/widgets/featured_heading.dart';
import 'package:plant_tracker/widgets/featured_tiles.dart';
import 'package:plant_tracker/widgets/floating_quick_access_bar.dart';
import 'package:plant_tracker/widgets/main_heading.dart';
import 'package:plant_tracker/widgets/menu_drawer.dart';
import 'package:plant_tracker/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';

class MyPlantsPage extends StatefulWidget {
  @override
  _MyPlantsPageState createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    // FloatingQuickAccessBar(
                    //   screenSize: screenSize,
                    // ),
                    // FeaturedHeading(screenSize: screenSize),
                    // MainHeading(screenSize: screenSize),
                    // FeaturedTiles(screenSize: screenSize),
                    SizedBox(height: screenSize.height / 15),
                    MainCarousel(),
                    SizedBox(height: screenSize.height / 10),
                    BottomBar(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}