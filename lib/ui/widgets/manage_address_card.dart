import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';

class ManageAddressCard extends StatelessWidget {
  const ManageAddressCard({
    Key? key,
    required this.type,
    required this.address,
    required this.code,
    required this.phone,
    required this.onEdit,
    required this.onDelete,
    required this.name,
    this.onCardTap,
  }) : super(key: key);

  final String name;
  final String type;
  final String address;
  final String code;
  final String phone;
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function()? onCardTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 25,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x29656161),
              offset: Offset(0, 2),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name ($type)',
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                '$code $phone',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              address,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(
                top: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: onEdit,
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xffe30000),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        onTap: onDelete,
                        child: Image.asset(
                          AssetConstants.bin,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
