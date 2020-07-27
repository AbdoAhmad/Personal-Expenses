import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalOfDay;
  final double precentageOfDay;

  ChartBar({this.label, this.totalOfDay, this.precentageOfDay});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              "\$${totalOfDay.toStringAsFixed(0)}",
              style: TextStyle(color: Theme.of(context).appBarTheme.color),
            ),
          ),
        ),
        Container(
          height: 75,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Theme.of(context).appBarTheme.color, width: 1.0),
                ),
              ),
              FractionallySizedBox(
                heightFactor: precentageOfDay,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Theme.of(context).appBarTheme.color, width: 1.0),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: TextStyle(color: Theme.of(context).appBarTheme.color),
        )
      ],
    );
  }
}
