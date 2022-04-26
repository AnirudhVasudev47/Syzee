import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/filter_model.dart';
import 'package:syzee/models/product_list_model.dart';
import 'package:syzee/ui/widgets/filter_options.dart';

class SortFilterButton extends StatefulWidget {
  const SortFilterButton(
      {Key? key,
      required this.sortTile,
      this.onLth,
      this.onHtl,
      this.onNew,
      this.onOld,
      this.priceRange,
      this.rateFilter,
      required this.colorList,
      required this.onView})
      : super(key: key);

  final int sortTile;
  final Function(FilterModel) onView;
  final VoidCallback? onLth;
  final VoidCallback? onHtl;
  final VoidCallback? onNew;
  final VoidCallback? onOld;

  final ProductTileModel colorList;

  final Function(int, int)? priceRange;
  final Function(int, int)? rateFilter;

  @override
  State<SortFilterButton> createState() => _SortFilterButtonState();
}

class _SortFilterButtonState extends State<SortFilterButton> {
  late int sortSelected;

  @override
  void initState() {
    super.initState();
    setState(() {
      sortSelected = widget.sortTile;
    });
  }

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

  Widget sortTile(String name, int value, BuildContext context, {onTap}) {
    return Container(
      color: sortSelected == value ? const Color(0x4d009c95) : Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap();
            setState(() {
              sortSelected = value;
            });
            Navigator.pop(context);
          },
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
                  Radio(
                    value: value,
                    groupValue: sortSelected,
                    onChanged: (i) {
                      onTap();
                      setState(() {
                        sortSelected = value;
                      });
                      Navigator.pop(context);
                    },
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

  @override
  Widget build(BuildContext context) {
    print(widget.colorList);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                // color is applied to main screen when modal bottom screen is displayed
                barrierColor: Colors.black.withOpacity(0.6),
                //background color for modal bottom screen
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                //elevates modal bottom screen
                // elevation: 10,
                // gives rounded corner to modal bottom screen
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                    expand: true,
                    maxChildSize: 1,
                    minChildSize: 1,
                    initialChildSize: 1,
                    builder: (context, scrollController) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          padding: const EdgeInsets.only(top: 75),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Filter By',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Expanded(
                                child: FilterOptions(
                                  colors: widget.colorList,
                                  controller: scrollController,
                                  onView: widget.onView,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                        ),
                  );
                },
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Image.asset(
                        AssetConstants.filter,
                        width: 21,
                        height: 21,
                      ),
                    ),
                    const Text(
                      'FILTER',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                // color is applied to main screen when modal bottom screen is displayed
                barrierColor: Colors.black.withOpacity(0.6),
                //background color for modal bottom screen
                backgroundColor: Colors.transparent,
                //elevates modal bottom screen
                // elevation: 10,
                // gives rounded corner to modal bottom screen
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      padding: const EdgeInsets.only(top: 25),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Sort By',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          sortTile(
                            'Low to high',
                            0,
                            context,
                            onTap: widget.onLth,
                          ),
                          customDivider(),
                          sortTile(
                            'High to low',
                            1,
                            context,
                            onTap: widget.onHtl,
                          ),
                          customDivider(),
                          sortTile(
                            'Oldest First',
                            2,
                            context,
                            onTap: widget.onOld,
                          ),
                          customDivider(),
                          sortTile(
                            'Newest First',
                            3,
                            context,
                            onTap: widget.onNew,
                          ),
                          ElevatedButton(
                            onPressed: () {
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
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Image.asset(
                        AssetConstants.sort,
                        width: 21,
                        height: 21,
                      ),
                    ),
                    const Text(
                      'SORT',
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
