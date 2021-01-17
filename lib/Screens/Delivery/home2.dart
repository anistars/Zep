// import 'package:authapp/Screens/Delivery/home1.dart';
import 'package:authapp/Screens/Delivery/home4.dart';
import 'package:authapp/Screens/Delivery/homepage.dart';
import 'package:flutter/material.dart';
import 'package:authapp/Screens/Delivery/home3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Something {
  String name;
  int quantity;
  double value;
  Something({String name, int quantity, double value}) {
    this.name = name;
    this.quantity = quantity;
    this.value = value;
  }
}

String maincourse;
void sample() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  maincourse = prefs.getString(maincourse);
  print(maincourse);
}

List<Something> someType = <Something>[];

class Recipt extends StatefulWidget {
  @override
  _ReciptState createState() => _ReciptState();
}

class _ReciptState extends State<Recipt> {
  List<String> name = <String>[];
  List<double> price = <double>[];
  List<int> qty1 = <int>[];
  @override
  Widget build(BuildContext context) {
    someType = [];
    double total = 0;
    int count = 0;
    List<Meal> name1 = ModalRoute.of(context).settings.arguments;
    for (var i = 0; i < name1.length; i++) {
      print("The ${name1[i].title},${name1[i].qty}");
      if (!(name.contains(name1[i].title))) {
        //  price.insert(0, name1[i].price);
        name.insert(0, name1[i].title);
        qty1.insert(0, name1[i].qty);
        price.insert(0, name1[i].price);
        if (name1[i].qty > 0) {
          someType.insert(
              0,
              Something(
                  name: name1[i].title,
                  quantity: name1[i].qty,
                  value: name1[i].price * name1[i].qty));
          total += name1[i].price * name1[i].qty;
        } else {
          continue;
        }
      } else {
        continue;
      }
      print("------------------");
      // print(name);
      // print(qty1);
      // print(price);
      print("Total Price is $total");
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: ListView.builder(
          itemCount: someType.length,
          itemBuilder: (context, index) {
            count = index + 1;
            return Card(
              margin: EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                        child: Text(
                          "$count. " + someType[index].name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(160, 0, 0, 0),
                          child: Text(
                            "Rs:-" + someType[index].value.toString(),
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                      ),
                      Text("Quantity:- " + someType[index].quantity.toString()),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
            height: 100.0,
            child: BottomAppBar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Payable Amount:- " + "$total",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Pay",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Cancle",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
