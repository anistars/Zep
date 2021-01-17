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
            Image.asset(
              'assets/images/homeLogo.png',
              height: size.height * 0.30,
            ),
            SizedBox(height: size.height * 0.05),
            RoundButton(
              text: 'LOGIN',
              onpresed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            SizedBox(height: size.height * 0.005),
            RoundButton(
              color: kPrimaryLightColor,
              text: 'SIGN UP',
              textColor: Colors.black,
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
