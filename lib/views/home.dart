import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../helper/analyticsHelper.dart';
import '../views/auth/login.dart';
import '../helper/formatHelper.dart';
import '../helper/httpHelper.dart';
import 'details/detail_product.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late HttpHelper helper;
  late List dataProducts;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyAnalyticsHelper analyticsHelper = MyAnalyticsHelper();

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    getProducts();
    dataProducts = [];

    FirebaseAnalytics.instance.setUserProperty(name: "MyHome", value: "Home");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DidaPedia"),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Color(0xff186F65),
          foregroundColor: Colors.white,
        ),
        body: productList(),
        drawer: drawerBurger(context));
  }

  Padding productList() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 12, right: 12, bottom: 12),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 12),
            elevation: 5,
            child: ListTile(
              leading: Image.network(
                dataProducts[index]['image'],
                width: 50,
                height: 50,
              ),
              title: Text(
                dataProducts[index]['title'],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: Text(CurrencyFormat.convertToIdr(
                  dataProducts[index]['price'] * 15000, 0)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xff186F65),
                  ),
                  Text(
                    dataProducts[index]['rating']['rate'].toString(),
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProduct(
                      title: dataProducts[index]['title'],
                      imageURL: dataProducts[index]['image'],
                      price: dataProducts[index]['price'] is int
                          ? dataProducts[index]['price'].toDouble()
                          : dataProducts[index]['price'],
                      rating: dataProducts[index]['rating']['rate'] is int
                          ? dataProducts[index]['rating']['rate'].toDouble()
                          : dataProducts[index]['rating']['rate'],
                      quantity: dataProducts[index]['rating']['count'],
                      description: dataProducts[index]['description'],
                      category: dataProducts[index]['category'],
                    ),
                  ),
                );
              },
            ),
          );
        },
        itemCount: dataProducts.length,
      ),
    );
  }

  Drawer drawerBurger(BuildContext context) {
    String? _email = _auth.currentUser!.email;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xff186F65)),
            currentAccountPicture: Image.network(
                "https://seeklogo.com/images/D/d-p-letter-logo-E428C66ABB-seeklogo.com.png"),
            accountName: Text(
              "DidaPedia",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              _email!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            child: Text("About app"),
            applicationIcon: Icon(
              Icons.shopping_bag,
              size: 35,
            ),
            applicationName: "Dida Pedia",
            applicationVersion: "1.0.0",
            applicationLegalese: "@didapediacompany",
            aboutBoxChildren: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Under Development"),
              )
            ],
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.rightFromBracket),
            title: Text("Log Out"),
            onTap: () {
              analyticsHelper.logoutLog(_email);
              _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  getProducts() async {
    return await helper.getProducts().then(
      (value) {
        if (mounted) {
          setState(() {
            dataProducts = value!.toList();
          });
        }
      },
    );
  }
}
