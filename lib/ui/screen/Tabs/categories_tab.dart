import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syzee/ui/widgets/category_kids.dart';
import 'package:syzee/ui/widgets/category_men.dart';
import 'package:syzee/ui/widgets/category_women.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: index,
      length: 3,
      child: Column(
        children: const [
          TabBar(
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Tab(text: 'Women'),
              Tab(text: 'Men'),
              Tab(text: 'Kids'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                CategoryWomen(),
                CategoryMen(),
                CategoryKids(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}