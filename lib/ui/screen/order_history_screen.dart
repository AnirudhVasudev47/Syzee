import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/models/order_list_model.dart';
import 'package:syzee/services/order_service.dart';
import 'package:syzee/ui/widgets/order_history_tile.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<OrderListModel> orderList;

  @override
  void initState() {
    super.initState();

    orderList = getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: currentTheme.currentTheme == ThemeMode.dark ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          AssetConstants.blackLogo,
          fit: BoxFit.contain,
          height: 55,
          width: 104,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Order History',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              color: Color(0xff009C95),
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
              child: FutureBuilder(
            future: orderList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                OrderListModel order = snapshot.data as OrderListModel;
                if (order.data.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'No orders found.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  itemCount: order.data.length,
                  itemBuilder: (context, index) {
                    return OrderHistoryTile(
                      orderNo: order.data[index].orderId,
                      productId: order.data[index].prodId.toString(),
                      price: order.data[index].price,
                      orderDate: order.data[index].date.toString(),
                      mainCatId: order.data[index].mainCatId.toString(),
                      status: order.data[index].status.toString(),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}

/*
Container(
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                      activeTrackHeight: 2,
                      inactiveTrackHeight: 2,
                      activeDividerRadius: 6,
                      inactiveDividerRadius: 6,
                      inactiveDividerColor: ThemeColors.mediumGrey,
                      activeDividerColor: ThemeColors.primaryColorLight),
                  child: SfSlider.vertical(
                    min: 1.0,
                    max: 5.0,
                    showLabels: true,
                    interval: 1,
                    isInversed: true,
                    showDividers: true,
                    value: 5,
                    labelFormatterCallback:
                        (dynamic actualValue, String formattedText) {
                      if (actualValue == 1) {
                        return 'Order Signed';
                      } else if (actualValue == 2) {
                        return 'Order Processed';
                      } else if (actualValue == 3) {
                        return 'Shipped ';
                      } else if (actualValue == 4) {
                        return 'Out for delivery';
                      } else {
                        return 'Delivered';
                      }
                    },
                    onChanged: (dynamic newValue) {
                      print(newValue);
                      setState(() {
                        _value = newValue;
                      });
                    },
                  ),
                ),
              ),
 */
