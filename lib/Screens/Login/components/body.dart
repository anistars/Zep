import 'dart:convert';
import 'dart:async';
import 'package:authapp/Screens/Delivery/home1.dart';
import 'package:authapp/Screens/Delivery/home3.dart';
import 'package:authapp/Screens/Delivery/homepage.dart';
import 'package:authapp/Screens/ForgotPassword/forgotPassword.dart';
import 'package:authapp/Screens/Login/components/background.dart';
import 'package:authapp/Screens/SignUp/signupscreen.dart';
import 'package:authapp/components/already_have_Account_Check.dart';
import 'package:authapp/components/round_buttons.dart';
import 'package:authapp/components/round_password_field.dart';
import 'package:authapp/components/rounded_input_field.dart';
import 'package:authapp/constraints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../login_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var mobileno, password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 2,
                    color: kPrimaryColor),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                'assets/icons/login2.svg',
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.person,
                hintText: "Mobile No",
                inputType: TextInputType.number,
                onChanged: (value) {
                  mobileno = value;
                  // print(mobileno);
                },
              ),
              RoundPasswordField(
                isPassword: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundButton(
                  text: "LOGIN",
                  onpresed: () async {
                    print("$mobileno,$password");
                    await login(mobileno, password);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String token = prefs.getString("token");
                    String id = prefs.getString("id");
                    print("$token");
                    print("$id");
                    if (token != null && id != null) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString("aniket", token);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreeen1(),
                            //FoodCheckout
                          ));
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "${Icons.error} Error",
                                style: TextStyle(color: Colors.red),
                              ),
                              content: Text('Email or password incorrect'),
                              actions: [
                                RaisedButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             LoginScreen()));
                                    })
                              ],
                            );
                          });
                    }
                  }),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAccountCheck(
                pressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new InkWell(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      // print("Clicked");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  login(mobileno, password) async {
    var url = "http://10.0.2.2:3000/login";
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode({
        'mobileno': mobileno,
        'password': password,
      }),
    );
    print(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var parse = jsonDecode(response.body);
    await prefs.setString('token', parse["token"]);
    await prefs.setString('id', parse["id"]);
    String token = prefs.getString("token");
    String id = prefs.getString("id");
    // print(token);
    // print(id);
  }
}
