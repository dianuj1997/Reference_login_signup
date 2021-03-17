import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sampleproject/registration.dart';
import 'package:sampleproject/main_page.dart';
import 'package:sampleproject/forgot_email.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'main_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Login',
    home: LoginForm(),
    theme: ThemeData(
        primaryColor: Colors.indigoAccent, accentColor: Colors.indigoAccent),
  ));
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  void getPermission() async {
    print("getPermission");
    // Map<PermissionGroup, PermissionStatus> permissions =
    // await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }

  final cryptor = new PlatformStringCryptor();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final _minpad = 5.0;


  local_store() async {}

  // retrieving_keys() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey("userData")) {
  //     return "No user key found";
  //   }
  //   final extractedUserData =
  //       json.decode(prefs.getString("userData")) as Map<String, Object>;
  //   final k_username = extractedUserData["k_username"];
  //   print("Username Key: " + k_username.toString());
  //   return k_username;
  // }

  @override
  Widget build(BuildContext context) {
    //TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('COVID Tracker'),
      ),
      body: Container(
          margin: EdgeInsets.all(_minpad * 2),
          child: Column(
            children: <Widget>[
              getImageAsset(),
              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad * 1),
                  child: Text(
                    "Login",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 40.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  )),

              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: TextField(
                    controller: myController1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'e.g. xyz@hotmail.com',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: TextField(
                    controller: myController2,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'only characters and numbers are allowed',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),

              Padding(
                padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                // child:
                // Expanded(
                // child:Padding(
                //      padding: EdgeInsets.only(top: _minpad,bottom: _minpad),
                //   child:
                child: ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Login'),
                      onPressed: () async {
                        final String k1 = await cryptor.generateRandomKey();
                        final String k2 = await cryptor.generateRandomKey();

                        final String encrypted1 =
                        await cryptor.encrypt(myController1.text, k1);
                        final String encrypted2 =
                        await cryptor.encrypt(myController2.text, k2);

                        final String F1 = encrypted1;
                        final String F2 = encrypted2;
                        print("F1 :" + F1.toString());
                        print("F2 :" + F2.toString());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              // return Sensor();
                            }));
                        // final ret = await retrieving_keys();
                        // print("User key : " + ret.toString());

                        if (0==0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                 return MainForm();
                              }));
                        } else {
                          print("login is not successfull");
                        }


                        debugPrint("Login is pressed");
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return MainForm();
                        // }));
                      },
                      elevation: 20.0,
                    )),
              ),

              // ),
              Padding(
                  padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                  child: RaisedButton(
                    child: Text('Signup'),
                    onPressed: () {
                      debugPrint("Signup is pressed");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return RegForm();
                          }));
                    },
                    elevation: 20.0,
                  )),
              Padding(
                padding: EdgeInsets.only(top: _minpad, bottom: _minpad),
                child: TextButton(
                    child: Text('Forgot Password?'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ForgotForm();
                          }));
                    }),

                // Text('Forgot Password?'),
              )
            ],
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/login_fig.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(
          left: _minpad * 10, right: _minpad * 10, top: _minpad * 10),
    );
  }
}
