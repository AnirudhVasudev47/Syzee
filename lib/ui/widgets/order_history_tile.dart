import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/order_product_details.dart';
import 'package:syzee/services/order_service.dart';
import 'package:syzee/ui/screen/track_order_screen.dart';

class OrderHistoryTile extends StatefulWidget {
  const OrderHistoryTile(
      {Key? key,
      required this.mainCatId,
      required this.productId,
      required this.orderDate,
      required this.orderNo,
      required this.price,
      required this.status})
      : super(key: key);

  final String mainCatId;
  final String productId;
  final String orderDate;
  final String orderNo;
  final String price;
  final String status;

  @override
  State<OrderHistoryTile> createState() => _OrderHistoryTileState();
}

class _OrderHistoryTileState extends State<OrderHistoryTile> {
  late var prod;
  String imageLink = '';

  @override
  void initState() {
    super.initState();
    prod = getProdDetails(widget.productId, widget.mainCatId);
    setState(() {
      imageLink = widget.mainCatId == "1"
          ? '${AssetConstants.mockImageLink}/women'
          : widget.mainCatId == "3"
              ? '${AssetConstants.mockImageLink}/men'
              : '${AssetConstants.mockImageLink}/kids';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prod,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          OrderProductDetails product = snapshot.data as OrderProductDetails;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackOrderScreen(
                    orderNo: widget.orderNo,
                    status: double.parse(widget.status),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 2,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Image.network(
                      '$imageLink/${product.image}',
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Order Date: ${widget.orderDate}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Order No: ${widget.orderNo}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Total Price: QAR ${widget.price}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 120,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
