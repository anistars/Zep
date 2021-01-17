import 'dart:convert';
import 'dart:async';
import 'package:authapp/Screens/History/history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:authapp/Screens/Login/components/body.dart';
import '../../main.dart';
import 'assets.dart';
import 'home2.dart';

class MainCourse {
  String title;
  int qty;
  double price;
  double total;
  MainCourse({
    String title,
    int qty,
    double price,
    double total,
  }) {
    this.title = title;
    this.qty = qty;
    this.price = price;
    this.total = total;
  }
  MainCourse.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        qty = json['qty'],
        price = json['price'],
        total = json['total'];

  Map<String, dynamic> toJson() =>
      {'title': title, 'qty': qty, 'price': price, 'total': total};
}

List<MainCourse> maincourse = <MainCourse>[];
Future<Album> fetchAlbum() async {
  final response = await http.get('http://10.0.2.2:3000/maincourse');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.statusCode);
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album1> fetchAlbum1() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("aniket");
  final response1 = await http.post('http://10.0.2.2:3000/personal_info',
      headers: {'Content-Type': 'application/json;charset=UTF-8'},
      body: jsonEncode({'token': token}));
  if (response1.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album1.fromJson(jsonDecode(response1.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  List<String> meal_info;
  List<String> meal_name;
  List<String> price;

  Album({this.meal_name, this.meal_info, this.price});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      meal_info: List<String>.from(json["meal_info"].map((x) => x)),
      meal_name: List<String>.from(json["meal_name"].map((x) => x)),
      price: List<String>.from(json["price"].map((x) => x)),
    );
  }
}

class Album1 {
  String msg;
  String msg1;
  String msg2;
  Album1({this.msg, this.msg1, this.msg2});
  factory Album1.fromJson(Map<String, dynamic> json) {
    return Album1(msg: json['msg'], msg1: json['msg1'], msg2: json['msg2']);
  }
}

void main() => runApp(MyApp());

class WelcomeScreeen2 extends StatefulWidget {
  WelcomeScreeen2({Key key}) : super(key: key);
  @override
  _WelcomeScreeen2State createState() => _WelcomeScreeen2State();
}

class _WelcomeScreeen2State extends State<WelcomeScreeen2> {
  int _selectIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
      if (index == 0) {
        Navigator.pop(context);
      }
      if (index == 1) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => WelcomeScreeen2(),
        //     ));
      }
    });
  }

  Future<Album> futureAlbum;
  Future<Album1> futureAlbum1;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    futureAlbum1 = fetchAlbum1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Course'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString("maincourse", json.encode(maincourse));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Recipt(),
                    // settings: RouteSettings(
                    //   arguments: maincourse,
                    // )
                  ));
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.meal_name);
              for (var i = 0; i < snapshot.data.meal_name.length; i++) {
                print({snapshot.data.meal_name[i]});
                return ListView.builder(
                    itemCount: snapshot.data.meal_name.length,
                    itemBuilder: (context, index) {
                      return OrderList(
                        title:
                            snapshot.data.meal_name[index].replaceAll('"', ' '),
                        description:
                            snapshot.data.meal_info[index].replaceAll('"', ' '),
                        qty: 2,
                        price: double.parse(
                            snapshot.data.price[index].replaceAll('"', ' ')),
                        bgColor: Colors.deepOrange,
                        image: thali,
                      );
                    });
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: [
            FutureBuilder<Album1>(
              future: futureAlbum1,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(
                      "${snapshot.data.msg},${snapshot.data.msg2},${snapshot.data.msg1}");
                  return UserAccountsDrawerHeader(
                    accountName: Text("${snapshot.data.msg}"),
                    accountEmail: Text("${snapshot.data.msg2}"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.green[100],
                      child: Text("${snapshot.data.msg1}"),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
            ListTile(
              title: new Text("Profile"),
              leading: new Icon(Icons.person),
              onTap: () {
                print("Directed to Profile page");
              },
            ),
            ListTile(
              title: new Text("History"),
              leading: new Icon(Icons.history),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ),
                );
              },
            ),
            ListTile(
              title: new Text("Sign Out"),
              leading: new Icon(Icons.logout),
              onTap: () {
                print("Signed Out");
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'MainCourse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Extra',
          ),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class OrderList extends StatefulWidget {
  String title;
  String description;
  int qty;
  double price;
  Color bgColor;
  String image;
  OrderList(
      {Key key,
      this.title,
      this.description,
      this.qty,
      this.price,
      this.bgColor,
      this.image})
      : super(key: key);
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  int counter1 = 0;
  // List<String> name = <String>[];
  // List<int> price1 = <int>[];
  @override
  Widget build(BuildContext context) {
    // name.insert(0, widget.title);
    // qty1.insert(0, widget.price);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20.0)),
            child: widget.image != null
                ? Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  )
                : null,
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(widget.description,
                    style: TextStyle(
                          color: Colors.green,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ) ??
                        'default value'),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 18.0,
                        padding: const EdgeInsets.all(2.0),
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            counter1--;
                          });
                          // count1.insert(0, counter1);
                          // name.insert(0, widget.title);
                          // qty1.insert(0, widget.price);
                          maincourse.insert(
                              0,
                              MainCourse(
                                  title: widget.title,
                                  qty: counter1,
                                  price: widget.price,
                                  total: counter1 * widget.price));
                        },
                      ),
                      Text(
                        "$counter1",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      IconButton(
                        iconSize: 18.0,
                        padding: const EdgeInsets.all(2.0),
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            counter1++;
                          });
                          // count1.insert(0, counter1);
                          // name.insert(0, widget.title);
                          // qty1.insert(0, widget.price);
                          maincourse.insert(
                              0,
                              MainCourse(
                                  title: widget.title,
                                  qty: counter1,
                                  price: widget.price,
                                  total: counter1 * widget.price));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "\Rs.${widget.price}",
            // style: priceTextStyle,
          ),
        ],
      ),
    );
  }
}
