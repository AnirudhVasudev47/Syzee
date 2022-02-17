import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/sub_category_model.dart';
import 'package:syzee/services/categories_service.dart';
import 'package:syzee/ui/screen/products_screen.dart';
import 'package:syzee/ui/widgets/appbar.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.id,
      required this.cat})
      : super(key: key);

  final int id;
  final String name;
  final String image;
  final MainCategory cat;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late Future<List<SubCategoryModel>> list;

  @override
  void initState() {
    list = getSubCategoryList(widget.id, widget.cat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                color: Color(0xff009B93),
              ),
            ),
          ),
          Image.network(
            widget.image,
            height: 254,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: list,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<SubCategoryModel> data =
                      snapshot.data as List<SubCategoryModel>;
                  return data.isNotEmpty ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsScreen(
                                    subCatId: data[index].id,
                                    cat: widget.cat,
                                    from: 'sub_category'
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 25,
                              ),
                              child: Text(
                                data[index].name,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Color(0xffEEEEEE),
                            height: 2,
                            thickness: 2,
                            indent: 25,
                            endIndent: 25,
                          )
                        ],
                      );
                    },
                  )
                  : const Center(
                    child: Text('No categories found'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

/*
ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 25,
                        ),
                        child: Text(
                          listData[index],
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color(0xffEEEEEE),
                      height: 2,
                      thickness: 2,
                      indent: 25,
                      endIndent: 25,
                    )
                  ],
                );
              },
            )
 */