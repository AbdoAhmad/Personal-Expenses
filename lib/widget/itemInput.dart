import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ItemInput extends StatefulWidget {
  final Function _addItem;
  ItemInput(this._addItem);

  @override
  _ItemInputState createState() => _ItemInputState();
}

class _ItemInputState extends State<ItemInput> {
  final _itemName = TextEditingController();

  final _itemPrice = TextEditingController();

  DateTime _pickedDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2035),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(50, 130, 184, 1),
            ),
            textTheme: GoogleFonts.permanentMarkerTextTheme(),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    ).then((value) {
      if (value == null) return;
      _pickedDate = value;
    });
  }

  void _submitData() {
    if (_itemName.text.isEmpty ||
        double.parse(_itemPrice.text) <= 0 ||
        _pickedDate == null) return;
    widget._addItem(
      _itemName.text,
      double.parse(_itemPrice.text),
      _pickedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          5, 5, 5, MediaQuery.of(context).viewInsets.bottom + 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
            child: TextField(
              controller: _itemName,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: "Name",
                hintText: "Name",
                filled: true,
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
                fillColor: Theme.of(context).accentColor,
                labelStyle: TextStyle(
                    color: Theme.of(context).appBarTheme.color, fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Theme.of(context).cardColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(150),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Theme.of(context).cardColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(150),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: TextField(
              controller: _itemPrice,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: "Price",
                hintText: "Price",
                filled: true,
                fillColor: Theme.of(context).accentColor,
                hintStyle: TextStyle(fontSize: 15),
                labelStyle: TextStyle(
                    color: Theme.of(context).appBarTheme.color, fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Theme.of(context).cardColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(150),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Theme.of(context).cardColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(150),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: (_pickedDate == null)
                    ? Container(
                        padding: EdgeInsets.all(5),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          "No Chosen Date !",
                          style: TextStyle(
                            color: Theme.of(context).appBarTheme.color,
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(5),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          "${DateFormat.yMMMd().format(_pickedDate)}",
                          style: TextStyle(
                            color: Theme.of(context).appBarTheme.color,
                          ),
                        ),
                      ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: _showDatePicker,
                  child: Text(
                    "Choose Date",
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).appBarTheme.color),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(150),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: _submitData,
              child: Text(
                "Add Item",
                style: TextStyle(
                    fontSize: 15, color: Theme.of(context).appBarTheme.color),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(150),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
