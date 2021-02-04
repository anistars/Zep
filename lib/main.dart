import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        'home': (context) => LoginSection(),
        // When navigating to the "/" route, build the FirstScreen widget.
        '/second': (context) => CupertinoTextFieldDemo(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/welcome': (context) => SecondScreen(),
      },
      home: Scaffold(
        body: LoginSection(),
      ),
    );
  }
}

// ignore: must_be_immutable
class CupertinoTextFieldDemo extends StatelessWidget {
  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                onChanged: (value) => email = value,
                placeholder: "Email",
                keyboardType: TextInputType.emailAddress,
                clearButtonMode: OverlayVisibilityMode.editing,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                onChanged: (value) => {password = value},
                placeholder: "Password",
                clearButtonMode: OverlayVisibilityMode.editing,
                obscureText: true,
                autocorrect: false,
              ),
            ),
            FlatButton.icon(
                onPressed: () async {
                  await signup(email, password);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String token = (prefs.getString('token'));
                  print(token);

                  if (token != null) {
                    Navigator.pushNamed(context, '/welcome');
                  }
                },
                icon: Icon(Icons.save),
                label: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginSection extends StatelessWidget {
  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    checkToken() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = (prefs.getString('token'));
        if (token != null) {
          Navigator.pushNamed(context, '/welcome');
        }
      } catch (e) {
        print('Some Thing Went wrong');
      }
    }

    checkToken();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                onChanged: (value) => email = value,
                placeholder: "Email",
                keyboardType: TextInputType.emailAddress,
                clearButtonMode: OverlayVisibilityMode.editing,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoTextField(
                onChanged: (value) => {password = value},
                placeholder: "Password",
                clearButtonMode: OverlayVisibilityMode.editing,
                obscureText: true,
                autocorrect: false,
              ),
            ),
            FlatButton.icon(
                onPressed: () async {
                  await login(email, password);
                  try {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String token = (prefs.getString('token'));
                    if (token != null) {
                      Navigator.pushNamed(context, '/welcome');
                    }
                  } catch (e) {
                    print('Some Thing Went wrong');
                  }
                },
                icon: Icon(Icons.login),
                label: Text('Login In')),
            FlatButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                icon: Icon(Icons.next_week_outlined),
                label: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}

//Login
login(email, password) async {
  print(email);
  print(password);
  var url = "http://10.0.2.2:5000/login"; // android
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  //Saving the Response in the form of token on device
  var parse = jsonDecode(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', parse['token']);
  print(response.body);
  // if (parse['msg'].isNotEmpty) {
  //   print(parse['msg']);
  // }
}

//sign up screen
signup(email, password) async {
  print(email);
  print(password);
  var url = "http://10.0.2.2:5000/signup"; // android
  final http.Response response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  //Saving the Response in the form of token on device
  print(response.body);
  var parse = jsonDecode(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', parse['token']);
}

//Welcome Screen
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', null);
            // Navigate back to first screen when tapped.
            Navigator.pop(context);
          },
          icon: Icon(Icons.logout),
          label: Text("Log Out"),
        ),
      ),
    );
  }
}
