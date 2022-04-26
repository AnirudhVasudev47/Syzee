import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/cart_model.dart';
import 'package:syzee/models/coupon_list_model.dart';
import 'package:syzee/services/cart_services.dart';
import 'package:syzee/services/order_service.dart';
import 'package:syzee/ui/screen/apply_coupon.dart';
import 'package:syzee/ui/screen/order_successful_screen.dart';
import 'package:syzee/ui/widgets/cart_list_tile.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({
    Key? key,
    required this.payMethod,
    required this.shippingAddress,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.type,
    required this.discount,
    required this.couponName,
  }) : super(key: key);

  final double discount;
  final String payMethod;
  final String shippingAddress;
  final String country;
  final String state;
  final String city;
  final String postalCode;
  final String type;
  final String couponName;

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  TextEditingController voucherText = TextEditingController();
  bool giftThis = false;
  late Future<CartModel?> cartInit;
  late CartModel cart;
  late Future<CouponListModel> coupons;
  double discountAmt = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    cartInit = fetchCartByEmail();
    coupons = getCouponList();
    setState(() {
      discountAmt = widget.discount;
    });
  }

  @override
  void dispose() {
    super.dispose();
    voucherText.dispose();
  }

  double calDiscount(double total, double discount) {
    double finalAmt = 0;
    double temp = discount / 100;
    finalAmt = total * temp;
    return finalAmt;
  }

  Widget chargesTile(String title, String desc, Color color, onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              desc,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: color,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
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
        body: FutureBuilder(
          future: cartInit,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cart = snapshot.data as CartModel;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ).copyWith(top: 35),
                      child: Image.asset(
                        'assets/images/checkout/process_summary.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cart.data.cart.length,
                      itemBuilder: (context, index) {
                        return CartListTile(
                          id: cart.data.cart[index].id.toString(),
                          mainId: cart.data.cart[index].mainId,
                          qty: cart.data.cart[index].quantity.toString(),
                          size: cart.data.cart[index].size.toString(),
                          image: cart.data.cart[index].image.toString(),
                          tagLine: cart.data.cart[index].tagLine.toString(),
                          name: cart.data.cart[index].name.toString(),
                          price: cart.data.cart[index].price.toString(),
                          deleteBtn: () async {
                            loadingDialog(context, asset: AssetConstants.loadingLottie);
                            var res = await deleteFromCart(
                                cart.data.cart[index].id, cart.data.cart[index].size);
                            if (res != null) {
                              // print ('over Here');
                              setState(() {
                                cartInit = fetchCartByEmail();
                                Navigator.pop(context);
                              });
                            }
                          },
                          updateBtn: (int qty) async {
                            loadingDialog(
                              context,
                              asset: AssetConstants.loadingLottie,
                            );
                            var res = await updateCart(
                                cart.data.cart[index].id, cart.data.cart[index].size, qty);
                            if (res != null) {
                              setState(() {
                                cartInit = fetchCartByEmail();
                                Navigator.pop(context);
                              });
                            }
                          },
                        );
                      },
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 16,
                      ),
                      child: const Text(
                        'Price Details',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Color(0xffB6874A),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    chargesTile(
                      'Total MRP',
                      'QAR ${cart.data.total}',
                      Colors.black,
                          () {},
                    ),
                    // chargesTile(
                    //   'Discount on MRP',
                    //   '-QAR 499',
                    //   const Color(0xff009B93),
                    // ),
                    chargesTile(
                      'Voucher discount',
                      discountAmt == 0 ? 'Apply coupon' : '- QAR ${discountAmt.toStringAsFixed(2)}',
                      const Color(0xff9B0000),
                          () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffa5a5a5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child: FutureBuilder(
                                      future: coupons,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          CouponListModel couponList = snapshot.data as CouponListModel;
                                          return couponList.data.isEmpty
                                              ? Center(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Lottie.asset(
                                                        AssetConstants.couponEmpty,
                                                        height: 200,
                                                        width: 200,
                                                      ),
                                                      const SizedBox(
                                                  height: 25,
                                                ),
                                                const Text(
                                                  'Sorry no coupons available at this moment',
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                              : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: couponList.data.length,
                                            itemBuilder: (context, index) {
                                              return ApplyCoupon(
                                                couponCode: couponList.data[index].code,
                                                minAmt: couponList.data[index].minimum,
                                                discountType: couponList.data[index].type,
                                                expiresOn: couponList.data[index].expiry,
                                                discount: couponList.data[index].amount,
                                                onTap: () {
                                                  int tot = cart.data.total;
                                                  if (tot > double.parse(couponList.data[index].minimum)) {
                                                          if (couponList.data[index].type == '%') {
                                                            setState(() {
                                                              Navigator.pop(context);
                                                              discountAmt =
                                                                  calDiscount(double.parse('$tot'), double.parse(couponList.data[index].amount));
                                                            });
                                                          } else {
                                                            setState(() {
                                                              Navigator.pop(context);
                                                              discountAmt = double.parse(couponList.data[index].amount);
                                                            });
                                                    }
                                                  } else {
                                                    Navigator.pop(context);
                                                    displayToast(
                                                      context,
                                                            title: 'Not enough items',
                                                            desc: 'Add more items to apply this coupon code.',
                                                            type: 'Danger',
                                                          );
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    chargesTile(
                      'Delivery Charges',
                      'QAR ${cart.data.noOfItems * 45}',
                      Colors.black,
                          () {},
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Color(0xffB6874A),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'QAR ${(cart.data.noOfItems * 45) + cart.data.total - discountAmt}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Color(0xffB6874A),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 16,
                      ).copyWith(bottom: 8),
                      child: const Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: Text(
                        '${widget.shippingAddress}, ${widget.country}, ${widget.state}, ${widget.city}, ${widget.postalCode}',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 8,
                        ),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Change Delivery Address',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Color(0xff9B0000),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Color(0xffB6874A),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 16,
                      ).copyWith(bottom: 8),
                      child: const Text(
                        'Payment',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 16,
                      ).copyWith(bottom: 8),
                      child: Row(
                        children: [
                          Image.asset(
                            widget.payMethod == 'online'
                                ? 'assets/images/checkout/master_card.png'
                                : 'assets/images/checkout/cash.png',
                            height: 42,
                            width: 60,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.payMethod == 'online' ? 'Pay Online' : 'Pay with cash',
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff4b4b4b),
                                  ),
                                ),
                                // Text(
                                //   '****  ****  ****  4543',
                                //   style: TextStyle(
                                //     fontFamily: 'Montserrat',
                                //     fontSize: 16,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/checkout/checkbox.png',
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 8,
                        ),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Change Payment Method',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Color(0xff9B0000),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xff169B93),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 45,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            loadingDialog(context, asset: 'assets/images/home/lottie/loading.json');
                            // var html = await getPaymentGateway();
                            //
                            // showModalBottomSheet(
                            //   context: context,
                            //   // color is applied to main screen when modal bottom screen is displayed
                            //   barrierColor: Colors.black.withOpacity(0.6),
                            //   //background color for modal bottom screen
                            //   backgroundColor: Colors.transparent,
                            //   isScrollControlled: true,
                            //   isDismissible: false,
                            //   //elevates modal bottom screen
                            //   // elevation: 10,
                            //   // gives rounded corner to modal bottom screen
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //   ),
                            //   builder: (BuildContext context) {
                            //     return BackdropFilter(
                            //       filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            //       child: Container(
                            //         padding: const EdgeInsets.only(top: 75),
                            //         decoration: const BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.only(
                            //             topLeft: Radius.circular(10),
                            //             topRight: Radius.circular(10),
                            //           ),
                            //         ),
                            //         height: MediaQuery.of(context).size.height,
                            //         child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: <Widget>[
                            //             const Text(
                            //               'Pay Online',
                            //               style: TextStyle(
                            //                 fontFamily: 'Montserrat',
                            //                 fontSize: 18,
                            //                 fontWeight: FontWeight.w500,
                            //                 color: Colors.black,
                            //               ),
                            //             ),
                            //             const SizedBox(
                            //               height: 14,
                            //             ),
                            //             Expanded(
                            //               child: WebView(
                            //                 initialUrl: Uri.dataFromString(html, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
                            //                 javascriptMode: JavascriptMode.unrestricted,
                            //                 allowsInlineMediaPlayback: true,
                            //                 zoomEnabled: true,
                            //                 navigationDelegate: (NavigationRequest request) {
                            //                   if (request.url.contains('udemy')) {
                            //                     var para1 = Uri.parse(request.url);
                            //
                            //                     print('qdata: ' + para1.queryParameters.toString());
                            //
                            //                     //You can do anything
                            //
                            //                     //Prevent that url works
                            //                     return NavigationDecision.navigate;
                            //                   }
                            //                   //Any other url works
                            //                   return NavigationDecision.navigate;
                            //                 },
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );

                            String id = await placeOrder(
                              widget.shippingAddress,
                              widget.country,
                              widget.state,
                              widget.city,
                              widget.postalCode,
                              widget.type,
                              cart.data.total,
                              discountAmt,
                              'null',
                              (cart.data.noOfItems * 45) + cart.data.total - discountAmt,
                              widget.payMethod == 'online' ? 1 : 0,
                              'testID',
                              widget.couponName,
                            );
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderSuccessfulScreen(
                                  orderId: id,
                                ),
                              ),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff169B93),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 45,
                            ),
                          ),
                          child: const Text(
                            'Pay',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
