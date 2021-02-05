import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';

class BarChart extends StatelessWidget {
  BarChart(this.weeklySpending);
  final List<double> weeklySpending;

  double maxHeight = 0;
  @override
  Widget build(BuildContext context) {
    weeklySpending.forEach((element) {
      if (element > maxHeight) {
        maxHeight = element;
      }
    });
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Text(
          'Weekly Spending',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            Text(
              'Jan 20 2021 - Jan 27 2021',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Graph(maxHeight, 'mon', weeklySpending[0]),
              Graph(maxHeight, 'tue', weeklySpending[1]),
              Graph(maxHeight, 'wed', weeklySpending[2]),
              Graph(maxHeight, 'thu', weeklySpending[3]),
              Graph(maxHeight, 'fri', weeklySpending[4]),
              Graph(maxHeight, 'sat', weeklySpending[5]),
              Graph(maxHeight, 'sun', weeklySpending[6]),
            ],
          ),
        )
      ],
    );
  }
}

class Graph extends StatelessWidget {
  Graph(this.maxHeight, this.label, this.height);
  final maxHeight;
  final label;
  final height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '\$${height.toStringAsFixed(1)}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.green[700],
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: height / maxHeight * 150,
          width: 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
