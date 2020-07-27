import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revision/model/item.dart';

import 'chartbar.dart';

class Chart extends StatelessWidget {
  final List<Item> recentItems;

  Chart({this.recentItems});

  List<Map<String, Object>> get _charbarContent {
    return List.generate(
      7,
      (index) {
        var totalSumOfDay = 0.0;
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        for (var i = 0; i < recentItems.length; i++) {
          if (recentItems[i].itemPickedDate.day == weekDay.day &&
              recentItems[i].itemPickedDate.month == weekDay.month &&
              recentItems[i].itemPickedDate.year == weekDay.year)
            totalSumOfDay += recentItems[i].itemPrice;
        }
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'price': totalSumOfDay
        };
      },
    ).reversed.toList();
  }

  double get totalSumOfWeek {
    // return recentItems.fold(0.0, (previousValue, element) {
    //   return previousValue + element.itemPrice;
    // });
    return _charbarContent.fold(
      0.0,
      (previousValue, element) {
        return previousValue + element['price'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _charbarContent.map((element) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: element['day'],
                totalOfDay: element['price'],
                precentageOfDay: totalSumOfWeek == 0.0
                    ? 0.0
                    : (element['price'] as double) / totalSumOfWeek,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
