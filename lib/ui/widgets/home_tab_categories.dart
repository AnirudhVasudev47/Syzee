import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:syzee/services/home_tab.dart';
import 'package:syzee/ui/layouts/home_tab_categories.dart';

class HomeTabCategories extends StatefulWidget {
  const HomeTabCategories({Key? key}) : super(key: key);

  @override
  State<HomeTabCategories> createState() => _HomeTabCategoriesState();
}

class _HomeTabCategoriesState extends State<HomeTabCategories> {
  late Future<List<Map<String, dynamic>>> listData;

  @override
  void initState() {
    super.initState();
    listData = getHomeCategories();
  }

  @override
  Widget build(BuildContext context) {
    getHomeCategories();
    return FutureBuilder(
      future: listData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> dataList =
              snapshot.data as List<Map<String, dynamic>>;
          return ListView.builder(
            itemCount: dataList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return HomeTabCategoriesLayout(
                image: dataList[index]['image'],
                name: dataList[index]['text'],
              );
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SkeletonGridLoader(
              builder: Card(
                color: Colors.transparent,
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 10,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 70,
                        height: 10,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              items: 3,
              itemsPerRow: 3,
              period: const Duration(seconds: 1),
              highlightColor: const Color(0xffd7d7d7),
              direction: SkeletonDirection.ltr,
              childAspectRatio: 150/190
            ),
          );
        }
      },
    );
  }
}
