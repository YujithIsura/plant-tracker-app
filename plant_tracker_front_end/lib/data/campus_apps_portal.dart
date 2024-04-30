import 'dart:developer';
import 'package:plant_tracker/data/person.dart';

import '../auth.dart';

final campusAppsPortalInstance = CampusAppsPortal()
  ..setJWTSub('jwt-sub-id123')
  ..setDigitalId('digital-id123')
  ..setUserPerson(
      Person(id: 2, jwt_sub_id: 'jwt-sub-id123'));

final campusAppsPortalPersonMetaDataInstance = CampusAppsPortalPersonMetaData()
  ..setScopes('address email');

class CampusAppsPortal {
  List<Person>? persons = [];
  Person userPerson = Person();
  String? user_jwt_sub;
  String? user_jwt_email;
  String? user_digital_id;
  CampusAppsPortalAuth? auth;
  bool signedIn = false;


  void setSignedIn(bool value) {
    signedIn = value;
  }

  bool getSignedIn() {
    return signedIn;
  }

  void setAuth(CampusAppsPortalAuth auth) {
    this.auth = auth;
  }

  CampusAppsPortalAuth? getAuth() {
    return this.auth;
  }

  Future<bool> getAuthSignedIn() async {
    final signedIn = await auth!.getSignedIn();
    return signedIn;
  }

  void setUserPerson(Person person) {
    userPerson = person;
  }

  Person getUserPerson() {
    return userPerson;
  }

  void setJWTSub(String? jwt_sub) {
    user_jwt_sub = jwt_sub;
  }

  String? getJWTSub() {
    return user_jwt_sub;
  }

  void setDigitalId(String? jwt_sub) {
    user_digital_id = jwt_sub;
  }

  String? getDigitalId() {
    return user_digital_id;
  }

  void setJWTEmail(String? jwt_email) {
    user_jwt_email = jwt_email;
  }

  String? getJWTEmail() {
    return user_jwt_email;
  }

  void setPersons(List<Person>? persons) {
    this.persons = persons;
  }

  void fetchPersonForUser() async {
    // check if user is in database person table
    try {
      Person person = campusAppsPortalInstance.getUserPerson();
      if (person.digital_id == null ||
          person.digital_id != this.user_digital_id!) {
        person = await fetchPerson(this.user_digital_id!);
        this.userPerson = person;
        log('Campus Apps Portal - fetchPersonForUser: ' +
            person.toJson().toString());
        print('Campus Apps Portal - fetchPersonForUser: ' +
            person.toJson().toString());
        campusAppsPortalInstance.setUserPerson(person);
      }
    } catch (e) {
      print(
          'Campus Apps Portal fetchPersonForUser :: Error fetching person for user');
      print(e);
    }
  }

  void addPerson(Person person) {
    persons!.add(person);
  }
}

class CampusAppsPortalPersonMetaData {
  String? _scopes;

  void setScopes(String scopes) {
    _scopes = scopes;
  }

  List<String>? getScopes() {
    if (_scopes == null) {
      return null;
    }
    return _scopes!.split(' ');
  }
}
