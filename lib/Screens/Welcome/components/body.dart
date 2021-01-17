import 'package:authapp/Screens/Login/login_screen.dart';
import 'package:authapp/Screens/SignUp/signupscreen.dart';
import 'package:authapp/Screens/Welcome/components/backGround.dart';
import 'package:authapp/constraints.dart';
import 'package:flutter/material.dart';
import 'package:authapp/components/round_buttons.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To Zep'.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kPrimaryColor),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              'assets/images/homeLogo.png',
              height: size.height * 0.20,
            ),
            SizedBox(height: size.height * 0.10),
            RoundButton(
              text: 'LOGIN',
              onpresed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            RoundButton(
              color: kPrimaryColor,
              text: 'SIGN UP',
              // textColor: Colors.black,
              onpresed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
    //it will returns the size of the whole screen height and width
  }
}
