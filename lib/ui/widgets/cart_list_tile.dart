import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 21,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Image.asset(
                'assets/images/checkout/productImage.png',
                height: 125,
                width: 125,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Women Top',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 19,
                      ),
                    ),
                    const Text(
                      'Earthy lime green colour',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      'Sold by : Syzee international',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0x0f000000),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: const Text(
                            'Size : L',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0x0f000000),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: const Text(
                            'Qty: 1',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Color: Yellow ',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xffB2732B),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Text(
                      'QAR 2000',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff009B93)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AssetConstants.bin,
                height: 20,
                width: 20,
              ),
              const VerticalDivider(
                thickness: 2,
                width: 2,
                color: Color(0xffB6874A),
              ),
              Image.asset(
                AssetConstants.heartActive,
                height: 20,
                width: 20,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          thickness: 2,
          height: 2,
          color: Color(0xffB6874A),
        ),
      ],
    );
  }
}
