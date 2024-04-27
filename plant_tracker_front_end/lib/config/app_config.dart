import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static String apiUrl = '';
  static String plantTrackerBffApiUrl = '';
  static String BffApiKey = '';
  static String refreshToken = '';
  static String choreoSTSEndpoint = "";
  static String choreoSTSClientID = "Tpq3gnE66p7y1KRqffYi2GDr0Loa";
  static String asgardeoClientId = "ItvJE7jy6eWuGKfosqX08vhpTdAa";
  static String asgardeoTokenEndpoint = "";
  static var apiTokens = null;
  static String applicationName = 'Plant Tracker';
  static String applicationVersion = '1.0.0';
  static String asgardeoLogoutUrl = '';


  static Future<AppConfig> forEnvironment(String env) async {
    // load the json file
    String contents = "{}";
    try {
      contents = await rootBundle.loadString(
        'assets/config/$env.json',
      );
    } catch (e) {
      print(e);
    }

    // decode our json
    final json = jsonDecode(contents);
    plantTrackerBffApiUrl = json['plantTrackerBffApiUrl'];
    choreoSTSEndpoint = json['choreo_sts_endpoint'];
    asgardeoTokenEndpoint = json['asgardeo_token_endpoint'];
    asgardeoLogoutUrl = json['logout_url'];

    // convert our JSON into an instance of our AppConfig class
    return AppConfig();
  }

  String getApiUrl() {
    return apiUrl;
  }
}
