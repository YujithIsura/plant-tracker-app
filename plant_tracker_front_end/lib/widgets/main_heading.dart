import 'package:plant_tracker/widgets/responsive.dart';
import 'package:flutter/material.dart';

class MainHeading extends StatelessWidget {
  const MainHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.50,
        left: ResponsiveWidget.isSmallScreen(context)
            ? screenSize.width / 12
            : screenSize.width / 5,
        right: ResponsiveWidget.isSmallScreen(context)
            ? screenSize.width / 12
            : screenSize.width / 5,
      ),
      width: screenSize.width,
      child: Text(
        'Featured Categories',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
