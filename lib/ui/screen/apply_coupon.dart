import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/services/cart_services.dart';

class ApplyCoupon extends StatelessWidget {
  const ApplyCoupon({
    Key? key,
    required this.couponCode,
    required this.discount,
    required this.minAmt,
    required this.expiresOn,
    required this.discountType,
    required this.onTap,
  }) : super(key: key);

  final String couponCode;
  final String discount;
  final String minAmt;
  final DateTime expiresOn;
  final String discountType;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 3),
              color: Color(0x29000000),
              blurRadius: 6,
              spreadRadius: 0.1)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                couponCode,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Text(
                  'Apply Coupon',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.primaryColorLight,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            discountType == '%'
                ? 'Get $discount% discount on minimum purchase of QAR $minAmt.'
                : 'Get QAR $discount discount on minimum purchase of QAR $minAmt.',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Expires on: ${expiresOn.year}/${expiresOn.month}/${expiresOn.day}',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          )
        ],
      ),
    );
  }
}
