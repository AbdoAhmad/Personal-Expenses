import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revision/widget/chart.dart';
import 'package:revision/widget/itemInput.dart';
import 'package:revision/widget/itemlist.dart';
import 'package:revision/widget/splashscreen.dart';

import 'model/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.permanentMarkerTextTheme(),
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(15, 76, 117, 1),
          textTheme: GoogleFonts.permanentMarkerTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  fontSizeDelta: 3,
                ),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color.fromRGBO(50, 130, 184, 1),
          shape: RoundedRectangleBorder(),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color.fromRGBO(15, 76, 117, 1)),
        backgroundColor: Color.fromRGBO(50, 130, 184, 1),
        cardColor: Color.fromRGBO(187, 225, 250, 1),
        accentColor: Color.fromRGBO(187, 225, 250, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.system,
      home: MySplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> _listOfItems = [];

  void _addItem(String name, double price, DateTime date) {
    setState(() {
      _listOfItems.add(
        Item(
          id: date.toIso8601String(),
          itemName: name,
          itemPrice: price,
          itemPickedDate: date,
        ),
      );
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _listOfItems.removeAt(index);
    });
  }

  void _showSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (_) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Icon(
                Icons.expand_more,
                color: Theme.of(context).accentColor,
              ),
              Divider(
                color: Theme.of(context).accentColor,
                thickness: 1,
              ),
              ItemInput(_addItem),
            ],
          );
        });
  }

  List<Item> get _listOfrecentItems {
    return _listOfItems.where(
      (element) {
        return element.itemPickedDate.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: _showSheet,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Chart(
                recentItems: _listOfrecentItems,
              ),
              ItemList(
                _listOfItems,
                _deleteItem,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSheet,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
