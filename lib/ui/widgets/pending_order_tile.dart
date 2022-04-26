import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/order_product_details.dart';
import 'package:syzee/services/order_service.dart';

class PendingOrderTile extends StatefulWidget {
  const PendingOrderTile(
      {Key? key,
      required this.mainCatId,
      required this.productId,
      required this.orderDate,
      required this.orderNo,
      required this.price,
      required this.status,
      required this.dateSlot,
      required this.deliveryDate,
      required this.onSubmit})
      : super(key: key);

  final String mainCatId;
  final String productId;
  final String orderDate;
  final String orderNo;
  final String price;
  final String status;
  final List<String> dateSlot;
  final String deliveryDate;
  final Function() onSubmit;

  @override
  State<PendingOrderTile> createState() => _PendingOrderTileState();
}

class _PendingOrderTileState extends State<PendingOrderTile> {
  late Future<OrderProductDetails> prod;
  String imageLink = '';

  int selected = -1;

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
            onTap: () {},
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Order No: ${widget.orderNo}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Image.network(
                              '$imageLink/${product.image}',
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
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
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Confirm order delivery date to the seller',
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    widget.dateSlot.isEmpty
                        ? const Text(
                            'Delivery date yet to be assigned.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                          )
                        : widget.deliveryDate == ""
                            ? Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: widget.dateSlot.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected = index;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 5),
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: index == selected ? ThemeColors.primaryColorTransparent : Colors.white,
                                            border: Border.all(
                                              color: ThemeColors.primaryColorLight,
                                            ),
                                          ),
                                          child: Text(
                                            DateFormat('yyyy-MM-dd kk:mm').format(DateTime.parse(widget.dateSlot[index].toString())),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (selected == -1) {
                                        displayToast(context, title: 'No date selected!', desc: 'Please select a date to submit.');
                                      } else {
                                        loadingDialog(context);
                                        await updateDeliveryDate(widget.orderNo, DateFormat('y-MM-dd HH:mm:ss').format(DateTime.parse(widget.dateSlot[selected])));
                                        Navigator.pop(context);
                                        widget.onSubmit();
                                      }
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
                                      'Submit',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(
                                child: Text(
                                  'Your product will be delivered by ${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.parse(widget.deliveryDate))}',
                                  style: const TextStyle(fontFamily: 'Montserrat', fontSize: 12),
                                ),
                              ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
