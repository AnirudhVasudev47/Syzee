import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/ui/widgets/all_orders.dart';

import '../widgets/pending_orders.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

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
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                children: const [
                  TabBar(
                    dragStartBehavior: DragStartBehavior.down,
                    tabs: [
                      Tab(text: 'Pending Orders'),
                      Tab(text: 'All Orders'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        PendingOrdersTab(),
                        AllOrdersTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

