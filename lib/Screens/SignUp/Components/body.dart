import 'dart:convert';
import 'dart:io';
import 'package:authapp/Screens/Login/login_screen.dart';
import 'package:authapp/Screens/SignUp/Components/background.dart';
import 'package:authapp/components/already_have_Account_Check.dart';
import 'package:authapp/components/round_buttons.dart';
import 'package:authapp/components/round_password_field.dart';
import 'package:authapp/components/rounded_input_field.dart';
import 'package:authapp/constraints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String radioButtonVal = 'N';
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  var first_name, last_name, email, mobileno, password;

  @override
  Widget build(BuildContext context) {
    return BackGround(
        child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGN UP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 2,
                  color: kPrimaryColor),
            ),
            RoundedInputField(
                hintText: 'First Name',
                onChanged: (value) {
                  first_name = value;
                },
                icon: Icons.account_circle_sharp,
                inputType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty || !RegExp(r"^[a-zA-Z]").hasMatch(value)) {
                    return 'Enter a valid Mobile No!';
                  }
                  return null;
                }),
            RoundedInputField(
                hintText: 'Last Name',
                onChanged: (value) {
                  last_name = value;
                },
                icon: Icons.account_circle_sharp,
                inputType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty || !RegExp(r"^[a-zA-Z]").hasMatch(value)) {
                    return 'Enter a valid Mobile No!';
                  }
                  return null;
                }),
            RoundedInputField(
                hintText: 'Email',
                onChanged: (value) {
                  email = value;
                },
                icon: Icons.email_outlined,
                inputType: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid Mobile No!';
                  }
                  return null;
                }),
            RoundedInputField(
                hintText: 'Mobile Number',
                onChanged: (value) {
                  mobileno = value;
                },
                icon: Icons.phone,
                inputType: TextInputType.number,
                validator: (String value) {
                  if (value.isEmpty ||
                      value.length < 10 ||
                      !RegExp(r"^[0-9]").hasMatch(value)) {
                    return 'Enter a valid Mobile No!';
                  }
                  return null;
                }),
            RoundPasswordField(
              isPassword: true,
              onChanged: (value) {
                password = value;
              },
            ),
            Text(
              'Are You Employee of the MetalMan?',
              style: new TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'Y',
                  groupValue: radioButtonVal,
                  onChanged: (value) {
                    setState(() {
                      radioButtonVal = 'Y';
                    });
                  },
                  activeColor: kPrimaryColor,
                ),
                Text("Yes"),
                Radio(
                  value: 'N',
                  groupValue: radioButtonVal,
                  onChanged: (value) {
                    setState(() {
                      radioButtonVal = 'N';
                    });
                  },
                  activeColor: kPrimaryColor,
                ),
                Text("No")
              ],
            ),
            voidCheck(isEmployee: radioButtonVal),
            RoundButton(
              text: "Signup".toUpperCase(),
              onpresed: () async {
                // print(_first.text.toString() +
                //     _email.text +
                //     _last.text +
                //     _mobile.text +
                //     _password.text);
                if (!(_formKey.currentState.validate())) {
                  return;
                } else {
                  // print(password);
                  await signup(
                      first_name, last_name, email, mobileno, password);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String token = prefs.getString("token");
                  print(token);
                  if (token != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text('User already registered'),
                            actions: [
                              RaisedButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  })
                            ],
                          );
                        });
                    print("User already registered");
                  }
                }
              },
            ),
            AlreadyHaveAccountCheck(
              login: false,
              pressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    ));
  }

  voidCheck({String isEmployee}) {
    if (isEmployee == 'Y') {
      return RoundedInputField(
        hintText: 'Enter MetalMan\'s Employee Id',
        icon: Icons.contact_page,
        inputType: TextInputType.number,
      );
    }
    return Container();
  }

  signup(first_name, last_name, email, mobileno, password) async {
    var url = "http://10.0.2.2:3000/signup";
    final http.Response response = await http.post(url,
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: jsonEncode({
          "first_name": first_name,
          "last_name": last_name,
          "email": email,
          "mobileno": mobileno,
          "password": password
        }));
    print(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    await prefs.setString('token', parse['token']);
    // String token = prefs.getString("token");
    // print(token);
  }
}
