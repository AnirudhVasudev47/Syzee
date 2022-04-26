import 'package:flutter/material.dart';
import 'package:syzee/models/order_list_model.dart';
import 'package:syzee/services/order_service.dart';
import 'package:syzee/ui/widgets/order_history_tile.dart';

class AllOrdersTab extends StatefulWidget {
  const AllOrdersTab({Key? key}) : super(key: key);

  @override
  State<AllOrdersTab> createState() => _AllOrdersTabState();
}

class _AllOrdersTabState extends State<AllOrdersTab> {
  late Future<OrderListModel> orderList;

  @override
  void initState() {
    super.initState();

    orderList = getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
