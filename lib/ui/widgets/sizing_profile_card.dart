import 'package:flutter/material.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/sizing_service.dart';

class SizingProfileCard extends StatefulWidget {
  const SizingProfileCard({
    Key? key,
    required this.height,
    required this.heightUnit,
    required this.weight,
    required this.weightUnit,
    required this.onEdit,
    required this.id,
    required this.selectedId,
    required this.onTapCard,
    required this.onFunctionComplete,
  }) : super(key: key);

  final String height;
  final String heightUnit;
  final String weight;
  final String weightUnit;
  final String id;
  final String selectedId;
  final void Function() onEdit;
  final void Function() onTapCard;
  final VoidCallback onFunctionComplete;

  @override
  State<SizingProfileCard> createState() => _SizingProfileCardState();
}

class _SizingProfileCardState extends State<SizingProfileCard> {
  String id = '-1';

  @override
  void initState() {
    super.initState();
    setState(() {
      id = widget.selectedId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTapCard,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
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
            const SizedBox(
              height: 16,
            ),
            Text(
              'Height: ${widget.height} ${widget.heightUnit}',
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              'Weight: ${widget.weight} ${widget.weightUnit}',
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16,
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
                  Row(
                    children: [
                      Radio(
                        value: widget.id,
                        activeColor: ThemeColors.primaryColorLight,
                        groupValue: id,
                        onChanged: (String? value) {
                          widget.onTapCard();
                        },
                      ),
                      const Text(
                        'Use as main size',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: widget.onEdit,
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
                        width: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          loadingDialog(context, asset: AssetConstants.loadingLottie);
                          await deleteSizingProfile(widget.id);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          widget.onFunctionComplete();
                        },
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
