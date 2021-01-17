import 'package:authapp/Screens/Delivery/home2.dart';
import 'package:authapp/Screens/History/history.dart';
import 'package:flutter/material.dart';
import 'package:authapp/Screens/Delivery/assets.dart';

final priceTextStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

class Meal {
  String title;
  int qty;
  double price;
  double total;
  Meal({
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
}

List<Meal> meals = <Meal>[];
List<String> name = <String>[];
List<double> qty1 = <double>[];
List<int> count1 = <int>[];

class FoodCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Recipt(),
                      settings: RouteSettings(
                        arguments: meals,
                      )));
            },
          )
        ],
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ListView(
              padding: const EdgeInsets.fromLTRB(
                16.0,
                kToolbarHeight + 40.0,
                16.0,
                16.0,
              ),
              children: [
                Text(
                  "Todays Menu",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                OrderList(
                  title: "Meal 1",
                  description: "(2 Roti,Dal,Bhindi Fry,Rice)",
                  qty: 2,
                  price: 50,
                  bgColor: Colors.deepOrange,
                  image: thali,
                ),
                SizedBox(
                  height: 20.0,
                ),
                OrderList(
                  title: "Meal 2",
                  description: "(2 Roti,Dal,Bhindi Fry,Rice)",
                  qty: 2,
                  price: 70,
                  bgColor: Colors.deepOrange,
                  image: thali,
                ),
                SizedBox(
                  height: 20.0,
                ),
                OrderList(
                  title: "Meal 3",
                  description: "(2 Roti,Dal,Bhindi Fry,Rice)",
                  qty: 2,
                  price: 100,
                  bgColor: Colors.deepOrange,
                  image: meal,
                ),
                SizedBox(
                  height: 20.0,
                ),
                _buildDivider(),
                Text(
                  "Extras",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                OrderList(
                  title: "Samosa",
                  description: "",
                  qty: 2,
                  price: 12,
                  bgColor: Colors.deepOrange,
                  image: breakfast,
                ),
                SizedBox(height: 20.0),
                OrderList(
                  title: "Kachori",
                  description: "",
                  qty: 2,
                  price: 15,
                  bgColor: Colors.deepOrange,
                  image: breakfast,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 8.0),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(16.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.yellow.shade700,
                        child: Text(
                          "Pay",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          print("$name,$qty1,$count1");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recipt(),
                                settings: RouteSettings(
                                  arguments: meals,
                                )),
                          );
                        },
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 8.0),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(16.0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.yellow.shade700,
                        child: Text(
                          "Cancle",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ])
        ],
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Aniket"),
              accountEmail: Text("8888888888"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.green[100],
                child: Text("AR"),
              ),
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
    );
  }

  Container _buildDivider() {
    return Container(
      height: 2.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.circular(5.0),
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
                          count1.insert(0, counter1);
                          name.insert(0, widget.title);
                          qty1.insert(0, widget.price);
                          meals.insert(
                              0,
                              Meal(
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
                          count1.insert(0, counter1);
                          name.insert(0, widget.title);
                          qty1.insert(0, widget.price);
                          meals.insert(
                              0,
                              Meal(
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
            style: priceTextStyle,
          ),
        ],
      ),
    );
  }
}
