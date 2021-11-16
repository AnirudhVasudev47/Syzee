import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/ui/screen/address_screen.dart';
import 'package:syzee/ui/widgets/cart_list_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController voucherText = TextEditingController();
  bool giftThis = false;

  @override
  void dispose() {
    super.dispose();
    voucherText.dispose();
  }

  Widget chargesTile(String title, String desc, Color color) {
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
          Text(
            desc,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: color,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AssetConstants.customAppBar,
      body: SingleChildScrollView(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 25),
                    child: const Text(
                      '1 Item',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 21,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 25),
                    child: const Text(
                      'QAR 2000',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const CartListTile(),
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
              'QAR 1499',
              Colors.black,
            ),
            chargesTile(
              'Discount on MRP',
              '-QAR 499',
              const Color(0xff009B93),
            ),
            chargesTile(
              'Voucher discount',
              'Apply coupon',
              const Color(0xff9B0000),
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
                children: const [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'QAR 1000',
                    style: TextStyle(
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
                      builder: (context) => const AddressScreen(),
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
      ),
    );
  }
}
