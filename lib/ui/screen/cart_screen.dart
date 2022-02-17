import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/cart_model.dart';
import 'package:syzee/models/coupon_list_model.dart';
import 'package:syzee/services/cart_services.dart';
import 'package:syzee/ui/screen/address_screen.dart';
import 'package:syzee/ui/screen/apply_coupon.dart';
import 'package:syzee/ui/screen/cart_screen_empty.dart';
import 'package:syzee/ui/widgets/appbar.dart';
import 'package:syzee/ui/widgets/cart_list_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController voucherText = TextEditingController();
  bool giftThis = false;
  late Future<CartModel?> cartInit;
  late CartModel cart;
  late Future<CouponListModel> coupons;
  double discountAmt = 0;

  @override
  void initState() {
    super.initState();
    cartInit = fetchCartByEmail();
    coupons = getCouponList();
    // print(cartInit);
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
          GestureDetector(
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
      appBar: const CustomAppBar(
        showBag: false,
      ),
      body: FutureBuilder(
        future: cartInit,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cart = snapshot.data as CartModel;
            return cart.data.cart.isEmpty
                ? const CartEmptyScreen()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 12),
                          alignment: Alignment.center,
                          child: const Text(
                            'Cart',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 29,
                              color: Color(0xff009B93),
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0x4544b0ac),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                                child: Text(
                                  '${cart.data.noOfItems} Items',
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                                child: Text(
                                  'QAR ${cart.data.total}',
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                            ],
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
                                var res = await updateCart(cart.data.cart[index].id, cart.data.cart[index].size, qty);
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
                        const SizedBox(
                          height: 21,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            border: Border.all(
                              color: const Color(0xff009B93),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 250,
                                child: TextField(
                                  controller: voucherText,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Enter Voucher Code',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Ink(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text(
                                    'Apply',
                                    style: TextStyle(
                                      fontFamily: 'VarelaRound',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                fontWeight: FontWeight.w500),
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
                          discountAmt == 0
                              ? 'Apply coupon'
                              : '- QAR ${discountAmt.toStringAsFixed(2)}',
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
                                              CouponListModel couponList =
                                                  snapshot.data as CouponListModel;
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
                                                            if (tot >
                                                                double.parse(couponList
                                                                    .data[index].minimum)) {
                                                              if (couponList.data[index].type ==
                                                                  '%') {
                                                                setState(() {
                                                                  Navigator.pop(context);
                                                                  discountAmt = calDiscount(
                                                                      double.parse('$tot'),
                                                                      double.parse(couponList
                                                                          .data[index].amount));
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  Navigator.pop(context);
                                                                  discountAmt = double.parse(
                                                                      couponList
                                                                          .data[index].amount);
                                                                });
                                                              }
                                                            } else {
                                                              Navigator.pop(context);
                                                              displayToast(context,
                                                                  title: 'Not enough items',
                                                                  desc:
                                                                      'Add more items to apply this coupon code.',
                                                                  type: 'Danger');
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
                                discountAmt == 0
                                    ? 'QAR ${cart.data.total}'
                                    : 'QAR ${cart.data.total - discountAmt}',
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: giftThis,
                              activeColor: const Color(0xff009B93),
                              onChanged: (val) {
                                setState(() {
                                  giftThis = !giftThis;
                                });
                              },
                            ),
                            const Text(
                              'Gift wrap this order',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressScreen(
                                    voucher: discountAmt,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff169B93),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 72,
                              ),
                            ),
                            child: const Text(
                              'CHECKOUT',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
