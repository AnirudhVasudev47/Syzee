import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syzee/ui/widgets/category_kids.dart';
import 'package:syzee/ui/widgets/category_men.dart';
import 'package:syzee/ui/widgets/category_women.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({Key? key, required this.index, required this.changeTab}) : super(key: key);
  final int index;
  final void Function(int) changeTab;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: index,
      length: 3,
      child: Column(
        children: [
          const TabBar(
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
                CategoryWomen(
                  changeTab: changeTab,
                ),
                const CategoryMen(),
                CategoryKids(
                  changeTab: changeTab,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}