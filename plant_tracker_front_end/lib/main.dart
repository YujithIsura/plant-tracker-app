import 'dart:html';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plant_tracker/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:plant_tracker/auth.dart';
import 'package:plant_tracker/data/campus_apps_portal.dart';

import 'config/app_config.dart';

import 'screens/home_page.dart';

abstract class Constants {
  static const String currentEnvironment = String.fromEnvironment(
    'ENV',
    defaultValue: '',
  );

  static const String choreoSTSClientID = String.fromEnvironment(
    'choreo_sts_client_id',
    defaultValue: '',
  );

  static const String asgardeoClientId = String.fromEnvironment(
    'asgardeo_client_id',
    defaultValue: '',
  );
}

void main() async {
  setHashUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  String? currentEnvironment = Constants.currentEnvironment;

  if (currentEnvironment == 'prod') {
    // get variables from prod environment config.json
    await AppConfig.forEnvironment('prod');
    AppConfig.choreoSTSClientID = Constants.choreoSTSClientID;
    AppConfig.asgardeoClientId = Constants.asgardeoClientId;
  } else {
    await AppConfig.forEnvironment('dev');
  }

  MyApp myApp = MyApp();
  campusAppsPortalInstance.setAuth(myApp._auth);
  bool signedIn = await campusAppsPortalInstance.getSignedIn();
  log('signedIn 1: $signedIn! ');

  signedIn = await myApp._auth.getSignedIn();
  campusAppsPortalInstance.setSignedIn(signedIn);

  print("currentEnvironment: $currentEnvironment");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({
    super.key,
    this.initialRoute,
    this.isTestMode = false,
  });
  late final String? initialRoute;
  late final bool isTestMode;
  final _auth = CampusAppsPortalAuth();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final String loginRoute = '/signin';
  get isTestMode => false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Tracker',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: loginRoute,
      home: HomePage(),
      onGenerateRoute: (settings) {
        return RouteConfiguration.onGenerateRoute(settings);
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) =>
              Scaffold(body: Center(child: Text('Not Found'))),
        );
      },
    );
  }
}
