import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:plant_tracker/config/app_config.dart';


class PlantTracker{

  int? plant_id;
  String?  common_name;
  String? scientific_name;
  String? family;
  String? description;
  String? care_instructions;
  String? photo_url;
  String? origin;
  String? lighting_condition;
  String? substrate;
  String? growing_speed;
  int? category_id;
  String? date_added;

  PlantTracker({
    this.plant_id,
    this.common_name,
    this.scientific_name,
    this.family,
    this.description,
    this.care_instructions,
    this.photo_url,
    this.origin,
    this.lighting_condition,
    this.substrate,
    this.growing_speed,
    this.category_id,
    this.date_added,
  });

  factory PlantTracker.fromJson(Map<String, dynamic> json) {
    return PlantTracker(
      plant_id: json['plant_id'],
      common_name: json['common_name'],
      scientific_name: json['scientific_name'],
      family: json['family'],
      description: json['description'],
      care_instructions: json['care_instructions'],
      photo_url: json['photo_url'],
      origin: json['origin'],
      lighting_condition: json['lighting_condition'],
      substrate: json['substrate'],
      growing_speed: json['growing_speed'],
      category_id: json['category_id'],
      date_added: json['date_added'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (plant_id != null) 'plant_id': plant_id,
        if (common_name != null) 'common_name': common_name,
        if (scientific_name != null) 'scientific_name': scientific_name,
        if (family != null) 'family': family,
        if (description != null) 'description': description,
        if (care_instructions != null) 'care_instructions': care_instructions,
        if (photo_url != null) 'photo_url': photo_url,
        if (origin != null) 'origin': origin,
        if (lighting_condition != null) 'lighting_condition': lighting_condition,
        if (substrate != null) 'substrate': substrate,
        if (growing_speed != null) 'growing_speed': growing_speed,
        if (category_id != null) 'category_id': category_id,
        if (date_added != null) 'date_added': date_added,
      };
}

Future<PlantTracker> createPlant(PlantTracker plantTracker) async {
  final response = await http.post(
    Uri.parse('${AppConfig.plantTrackerBffApiUrl}/create_plant'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConfig.BffApiKey}',
    },
    body: jsonEncode(plantTracker.toJson()),
  );

  if (response.statusCode == 201) {
    log(response.body);
    PlantTracker createdPlantTracker = PlantTracker.fromJson(json.decode(response.body));
    return createdPlantTracker;
  } else {
    log("${response.body} Status code =${response.statusCode}");
    throw Exception('Failed to create plant tracker.');
  }
}

Future<List<PlantTracker>> fetchPlants() async {
  final response = await http.get(
    // Uri.parse('${AppConfig.campusAttendanceBffApiUrl}/address'),
    Uri.parse('${AppConfig.plantTrackerBffApiUrl}/plants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'Authorization': 'Bearer ${AppConfig.BffApiKey}',
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    log(resultsJson.toString());
    List<PlantTracker> todos = await resultsJson
        .map<PlantTracker>((json) => PlantTracker.fromJson(json))
        .toList();
    return todos;
  } else {
    throw Exception('Failed to load plant List');
  }
}
