import 'dart:developer';
import 'dart:io';

import 'package:plant_tracker/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:openid_client/openid_client_browser.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class LoginPage extends StatefulWidget {
  // final ValueChanged<Credentials> onSignIn;

  const LoginPage({
    // required this.onSignIn,
    super.key,
  });

  @override
  State<LoginPage> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LoginPage> {
  String _clientId = AppConfig.asgardeoClientId;
  final String _issuerUrl = AppConfig.asgardeoTokenEndpoint;

  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'email',
    'groups',
    'address',
    'phone'
  ];

  @override
  Widget build(BuildContext context) {
    log("in signin build -- asgardeoClientId is :" +
        AppConfig.asgardeoClientId);
    int count = 0;
    while (_clientId.isEmpty && count < 10) {
      log(count.toString() + " in Auth -- asgardeoClientId is empty");
      count++;
      if (count > 10) {
        break;
      }
      sleep(Duration(seconds: 1));
      _clientId = AppConfig.asgardeoClientId;
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign in"),
      // ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cover.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Container(
                    //width: 400,
                    // margin: EdgeInsets.only(left:400.0),
                    alignment: Alignment.center,
                    child: Wrap(children: [
                      Column(children: [
                        Text(
                          "Welcome to Plant Tracker",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Google Sans",
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          """To access the Plant Tracker features, please sign in.""",
                          style: TextStyle(
                            fontFamily: "Google Sans",
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Once you sign in, you'll be able to view and manage your plants.",
                          style: TextStyle(
                            fontFamily: "Google Sans",
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ]),
                    ]),
                  ),
                ),
              ),
              Container(
                //  margin: EdgeInsets.only(top: 20.0,left: 380.0),
                margin: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.yellowAccent),
                    shadowColor: MaterialStateProperty.all(Colors.lightBlue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/login.png',
                        fit: BoxFit.contain,
                        width: 40,
                      ),
                      Text(
                        "Login with Asgardeo",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Google Sans",
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await authenticate(
                        Uri.parse(_issuerUrl), _clientId, _scopes);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  authenticate(Uri uri, String clientId, List<String> scopes) async {
    log("signin authenticate - Client ID :: " + clientId);
    // create the client
    var issuer = await Issuer.discover(uri);
    var client = new Client(issuer, clientId);

    // create an authenticator
    var authenticator = new Authenticator(client, scopes: scopes);

    // starts the authentication
    authenticator.authorize();
  }
}
