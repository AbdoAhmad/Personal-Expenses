import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalOfDay;
  final double precentageOfDay;

  ChartBar({this.label, this.totalOfDay, this.precentageOfDay});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                child: Text(
                  "\$${totalOfDay.toStringAsFixed(0)}",
                  style: TextStyle(color: Theme.of(context).appBarTheme.color),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            Container(
              height: constraints.maxHeight * .6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Theme.of(context).appBarTheme.color,
                          width: 1.0),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: precentageOfDay,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.color,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Theme.of(context).appBarTheme.color,
                            width: 1.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            Container(
              height: constraints.maxHeight * .15,
              child: Text(
                label,
                style: TextStyle(color: Theme.of(context).appBarTheme.color),
              ),
            )
          ],
        );
      },
    );
  }
}
