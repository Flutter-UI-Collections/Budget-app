import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/helper_fun/color_provider.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/screens/bar_chart.dart';
import 'package:flutter_budget_ui/screens/category_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double amt) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(category),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '\$${(category.maxAmount - amt).toStringAsFixed(2)}/\$${(category.maxAmount.toStringAsFixed(2))}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constrants) {
              double heightBar = constrants.maxHeight;
              double widthBar = constrants.maxWidth;
              double value =
                  (((category.maxAmount - amt) / (category.maxAmount)) *
                      (widthBar));
              if (value < 0) {
                value = 0;
              }
              double percent = value / widthBar * 100;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Stack(
                  children: [
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                    ),
                    Container(
                      height: 16,
                      width: value,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: getColor(percent),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Row(
              children: [
                Center(
                  child: Text(
                    'Simple  Budget',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.2),
                  ),
                ),
              ],
            ),
            forceElevated: true,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
              iconSize: 30,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(
                  'https://www.competitionsciences.org/wp-content/uploads/2020/10/statistics-graph-illustration.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: 200,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {},
                iconSize: 30,
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BarChart(weeklySpending),
                  );
                } else {
                  Category category = categories[index - 1];
                  double amt = 0;
                  category.expenses.forEach((Expense expense) {
                    amt += expense.cost;
                  });
                  return _buildCategory(category, amt);
                }
              },
              childCount: 1 + categories.length,
            ),
          )
        ],
      ),
    );
  }
}
