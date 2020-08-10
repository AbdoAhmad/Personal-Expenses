import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revision/widget/chart.dart';
import 'package:revision/widget/itemInput.dart';
import 'package:revision/widget/itemlist.dart';
import 'package:revision/widget/splashscreen.dart';

import 'model/item.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

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

  bool _chartFlag = false;
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
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        //isScrollControlled: true,
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
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
            ),
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
    final showMySwitch = Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "show Chart !",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Switch(
              value: _chartFlag,
              onChanged: (val) {
                setState(() {
                  _chartFlag = val;
                });
              })
        ],
      ),
    );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        widget.title,
      ),
      actions: <Widget>[
        if (isLandscape) showMySwitch,
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: _showSheet,
        ),
      ],
    );
    final showMyItemList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          .7,
      child: ItemList(
        _listOfItems,
        _deleteItem,
      ),
    );
    final showMyLandScapeChart = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          .7,
      child: Chart(
        recentItems: _listOfrecentItems,
      ),
    );
    final showMyPortraitChart = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          .3,
      child: Chart(
        recentItems: _listOfrecentItems,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              if (!isLandscape) showMyPortraitChart,
              if (!isLandscape) showMyItemList,
              if (isLandscape)
                _chartFlag ? showMyLandScapeChart : showMyItemList,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
