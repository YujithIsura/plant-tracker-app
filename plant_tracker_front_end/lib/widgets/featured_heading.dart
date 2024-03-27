import 'package:plant_tracker/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FeaturedHeading extends StatelessWidget {
  const FeaturedHeading({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize.height * 0.60,
        left: ResponsiveWidget.isSmallScreen(context)
            ? screenSize.width / 12
            : screenSize.width / 5,
        right: ResponsiveWidget.isSmallScreen(context)
            ? screenSize.width / 12
            : screenSize.width / 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Featured',
            style: TextStyle(
                fontSize: 36,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Color(0xFF263b5e)),
          ),
          Expanded(
            child: Text(
              'Clue of the wooden cottage',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
