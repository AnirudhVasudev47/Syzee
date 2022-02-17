import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:syzee/services/home_tab.dart';

class HomeTabBrands extends StatefulWidget {
  const HomeTabBrands({Key? key}) : super(key: key);

  @override
  State<HomeTabBrands> createState() => _HomeTabBrandsState();
}

class _HomeTabBrandsState extends State<HomeTabBrands> {
  late Future<List<String>> brandList;

  @override
  void initState() {
    super.initState();
    brandList = getHomeTabBrands();
  }

  @override
  Widget build(BuildContext context) {
    getHomeTabBrands();
    return FutureBuilder<List<String>>(
      future: brandList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> data = snapshot.data as List<String>;
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.network(
                        data[0],
                        width: 170,
                        height: 224,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.network(
                        data[1],
                        width: 170,
                        height: 224,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.network(
                        data[2],
                        width: 170,
                        height: 224,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.network(
                        data[3],
                        width: 170,
                        height: 224,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                items: 4,
                itemsPerRow: 2,
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
/*
Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/home/home_tab/brand1.png',
                  width: 170,
                  height: 224,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/home/home_tab/brand2.png',
                  width: 170,
                  height: 224,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/home/home_tab/brand3.png',
                  width: 170,
                  height: 224,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/home/home_tab/brand4.png',
                  width: 170,
                  height: 224,
                ),
              ),
            ],
          ),
        ),
      ],
    );
 */
