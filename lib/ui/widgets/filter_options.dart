import 'package:flutter/material.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/models/filter_model.dart';
import 'package:syzee/models/product_list_model.dart';

class FilterOptions extends StatefulWidget {
  const FilterOptions({Key? key, required this.colors, required this.controller, required this.onView}) : super(key: key);

  final ProductTileModel colors;
  final ScrollController controller;
  final Function (FilterModel) onView;

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  bool showFilterOne = false;
  bool showFilterTwo = false;
  bool showFilterThree = false;

  List<int> filterOneValue = [0, 100000];
  List<int> filterTwoValue = [0, 5];
  String filterThreeValue = 'all';

  int filterIndexOne = -1;
  int filterIndexTwo = -1;
  int filterIndexThree = -1;

  Widget filterTile(String name, String value, {onTap}) {
    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          child: Ink(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 13,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'VarelaRound',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'VarelaRound',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget filterSubTile(String name, String value, int index, int filter, {onTap}) {
    return Container(
      color: filter == 1
          ? filterIndexOne == index
              ? ThemeColors.primaryColorTransparent
              : Colors.white
          : filter == 2
              ? filterIndexTwo == index
                  ? ThemeColors.primaryColorTransparent
                  : Colors.white
              : filterIndexThree == index
                  ? ThemeColors.primaryColorTransparent
                  : Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 13,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'VarelaRound',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return const Divider(
      color: Color(0xffEEEEEE),
      height: 2,
      thickness: 2,
      indent: 25,
      endIndent: 25,
    );
  }

  Widget customSubDivider() {
    return const Divider(
      color: Color(0xffEEEEEE),
      height: 2,
      thickness: 2,
      indent: 55,
      endIndent: 55,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.colors);
    return SingleChildScrollView(
      child: Column(
        children: [
          filterTile(
            'Price',
            ' ',
            onTap: () {
              setState(() {
                showFilterTwo = false;
                showFilterThree = false;
                showFilterOne = !showFilterOne;
              });
            },
          ),
          customDivider(),
          showFilterOne
              ? Column(
                  children: [
                    filterSubTile(
                      '10 QAR - 1000 QAR',
                      'All',
                      0,
                      1,
                      onTap: () {
                        var temp = [10, 1000];
                        setState(() {
                          filterOneValue = temp;
                          filterIndexOne = 0;
                        });
                      },
                    ),
                    customSubDivider(),
                    filterSubTile(
                      '1000 QAR - 5000 QAR',
                      'All',
                      1,
                      1,
                      onTap: () {
                        var temp = [1000, 5000];
                        setState(() {
                          filterOneValue = temp;
                          filterIndexOne = 1;
                        });
                      },
                    ),
                    customSubDivider(),
                    filterSubTile(
                      '5000 QAR - 7500 QAR',
                      'All',
                      2,
                      1,
                      onTap: () {
                        var temp = [5000, 7500];
                        setState(() {
                          filterOneValue = temp;
                          filterIndexOne = 2;
                        });
                      },
                    ),
                    customSubDivider(),
                    filterSubTile(
                      '7500 QAR - 10000 QAR',
                      'All',
                      3,
                      1,
                      onTap: () {
                        var temp = [7500, 10000];
                        setState(() {
                          filterOneValue = temp;
                          filterIndexOne = 3;
                        });
                      },
                    ),
                    customDivider(),
                  ],
                )
              : Container(),
          filterTile('Product Ratings', ' ', onTap: () {
            setState(() {
              showFilterThree = false;
              showFilterOne = false;
              showFilterTwo = !showFilterTwo;
            });
          }),
          customDivider(),
          showFilterTwo
              ? Column(
                  children: [
                    filterSubTile(
                      '1 ⭐ & above',
                      'All',
                      0,
                      2,
                      onTap: () {
                        var temp = [1, 5];
                        setState(() {
                          filterTwoValue = temp;
                          filterIndexTwo = 0;
                        });
                      },
                    ),
                    customSubDivider(),
                    filterSubTile(
                      '2 ⭐ & above',
                      'All',
                      1,
                      2,
                      onTap: () {
                        var temp = [2, 5];
                        setState(() {
                          filterTwoValue = temp;
                          filterIndexTwo = 1;
                        });
                      },
                    ),
                    customSubDivider(),
                    filterSubTile(
                      '3 ⭐ & above',
                      'All',
                      2,
                      2,
                      onTap: () {
                        var temp = [3, 5];
                        setState(() {
                          filterTwoValue = temp;
                          filterIndexTwo = 2;
                        });
                      },
                    ),
                    customSubDivider(),
                    filterSubTile(
                      '4 ⭐ & above',
                      'All',
                      3,
                      2,
                      onTap: () {
                        var temp = [4, 5];
                        setState(() {
                          filterTwoValue = temp;
                          filterIndexTwo = 3;
                        });
                      },
                    ),
                    customSubDivider(),
                    filterSubTile(
                      '5 ⭐ & above',
                      'All',
                      4,
                      2,
                      onTap: () {
                        var temp = [5, 5];
                        setState(() {
                          filterTwoValue = temp;
                          filterIndexTwo = 4;
                        });
                      },
                    ),
                    customDivider(),
                  ],
                )
              : Container(),
          filterTile('Colors', ' ', onTap: () {
            setState(() {
              showFilterOne = false;
              showFilterTwo = false;
              showFilterThree = !showFilterThree;
            });
          }),
          customDivider(),
          showFilterThree
              ? ListView.builder(
                  controller: widget.controller,
                  shrinkWrap: true,
                  itemCount: widget.colors.data.length,
                  itemBuilder: (context, index) {
                    return filterSubTile(
                      widget.colors.data[index].color,
                      'All',
                      index,
                      3,
                      onTap: () {
                        var temp = widget.colors.data[index].color;
                        setState(() {
                          filterThreeValue = temp;
                          filterIndexThree = index;
                        });
                      },
                    );
                  },
                )
              : Container(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: ElevatedButton(
              onPressed: () {
                FilterModel filter = FilterModel(
                  filterOneValues: filterOneValue,
                  filterTwoValues: filterTwoValue,
                  filterThreeValues: filterThreeValue,
                );
                widget.onView(filter);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff169B93),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 45,
                ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
