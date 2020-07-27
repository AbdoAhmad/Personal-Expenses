import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:revision/model/item.dart';

class ItemList extends StatelessWidget {
  final List<Item> _listOfItems;
  final Function _deleteItem;
  ItemList(this._listOfItems, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    return (_listOfItems.isEmpty)
        ? Container(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 75),
            child: Column(
              children: <Widget>[
                Text(
                  'No Items added yet !',
                  style: TextStyle(
                      color: Theme.of(context).appBarTheme.color, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                // Image.asset(
                //   "assets\\image\\waiting.jpg",
                //   fit: BoxFit.cover,
                // ),
                Icon(
                  Icons.warning,
                  size: 100,
                  color: Theme.of(context).appBarTheme.color,
                ),
              ],
            ),
          )
        : Container(
            height: 450,
            child: ListView.builder(
              itemBuilder: (ctx, counter) {
                return Card(
                  elevation: 20,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "\$ ${_listOfItems[counter].itemPrice}",
                            style: GoogleFonts.permanentMarker(
                                fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                      backgroundColor: Theme.of(context).appBarTheme.color,
                      radius: 30,
                    ),
                    title: Text(
                      _listOfItems[counter].itemName,
                      style:
                          TextStyle(color: Theme.of(context).appBarTheme.color),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(_listOfItems[counter].itemPickedDate),
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).appBarTheme.color,
                        ),
                        onPressed: () {
                          _deleteItem(counter);
                        }),
                  ),
                );
              },
              itemCount: _listOfItems.length,
            ),
          );
  }
}
