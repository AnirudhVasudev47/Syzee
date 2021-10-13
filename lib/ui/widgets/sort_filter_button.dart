import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';

class SortFilterButton extends StatelessWidget {
  const SortFilterButton({Key? key}) : super(key: key);

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
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8.0),
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

  Widget customDivider () {
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
                      padding: const EdgeInsets.only(
                        top: 25
                      ),
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
                          filterTile('Product Type', 'All'),
                          customDivider(),
                          filterTile('Style', 'All'),
                          customDivider(),
                          filterTile('Material', 'All'),
                          customDivider(),
                          filterTile('Brand', 'All'),
                          customDivider(),
                          filterTile('Body Fit', 'All'),
                          customDivider(),
                          filterTile('Size', 'All'),
                          customDivider(),
                          filterTile('Price', 'All'),
                          ElevatedButton(
                            onPressed: () {},
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
                              'View All',
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
                      padding: const EdgeInsets.only(
                          top: 25
                      ),
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
                          filterTile('Product Type', 'All'),
                          customDivider(),
                          filterTile('Style', 'All'),
                          customDivider(),
                          filterTile('Material', 'All'),
                          customDivider(),
                          filterTile('Brand', 'All'),
                          customDivider(),
                          filterTile('Body Fit', 'All'),
                          customDivider(),
                          filterTile('Size', 'All'),
                          customDivider(),
                          filterTile('Price', 'All'),
                          ElevatedButton(
                            onPressed: () {},
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
                              'View All',
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
