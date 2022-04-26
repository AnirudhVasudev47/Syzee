import 'package:flutter/material.dart';
import 'package:syzee/models/pending_order_model.dart';
import 'package:syzee/services/order_service.dart';
import 'package:syzee/ui/widgets/pending_order_tile.dart';

class PendingOrdersTab extends StatefulWidget {
  const PendingOrdersTab({Key? key}) : super(key: key);

  @override
  State<PendingOrdersTab> createState() => _PendingOrdersTabState();
}

class _PendingOrdersTabState extends State<PendingOrdersTab> {
  late Future<PendingOrderModel> orderList;

  @override
  void initState() {
    super.initState();
    orderList = getPendingOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: orderList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          PendingOrderModel order = snapshot.data as PendingOrderModel;
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
              return PendingOrderTile(
                orderNo: order.data[index].orderId,
                productId: order.data[index].prodId.toString(),
                price: order.data[index].price,
                orderDate: order.data[index].date.toString(),
                mainCatId: order.data[index].mainCatId.toString(),
                status: order.data[index].status.toString(),
                dateSlot: order.data[index].dateSlot,
                deliveryDate: order.data[index].deliveryDate.toString(),
                onSubmit: () {
                  setState(() {
                    orderList = getPendingOrderList();
                  });
                },
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
