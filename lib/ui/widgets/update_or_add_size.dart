import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syzee/global/color.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/sizing_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

enum AddressType { home, office, other }

class UpdateOrAddSize extends StatefulWidget {
  const UpdateOrAddSize({
    Key? key,
    required this.action,
    this.height,
    this.weight,
    this.total,
    this.shoulder,
    this.chest,
    this.sleeves,
    this.waist,
    this.waistFromNeck,
    this.chestFromNeck,
    this.hips,
    this.upperValue,
    this.lowerValue,
    this.id,
    required this.onFunctionComplete,
  }) : super(key: key);

  final String action;
  final String? height;
  final String? weight;
  final String? total;
  final String? shoulder;
  final String? chest;
  final String? sleeves;
  final String? waist;
  final String? waistFromNeck;
  final String? chestFromNeck;
  final String? hips;
  final double? upperValue;
  final double? lowerValue;
  final int? id;
  final VoidCallback onFunctionComplete;

  @override
  State<UpdateOrAddSize> createState() => _UpdateOrAddSizeState();
}

class _UpdateOrAddSizeState extends State<UpdateOrAddSize> {
  List<String> weightArr = ['kg', 'lb'];
  List<String> heightArr = ['cm', 'ft'];

  double upperValue = 6.0;
  double lowerValue = 6.0;

  TextEditingController heightText = TextEditingController();
  TextEditingController weightText = TextEditingController();
  TextEditingController totalText = TextEditingController();
  TextEditingController shoulderText = TextEditingController();
  TextEditingController chestText = TextEditingController();
  TextEditingController sleevesText = TextEditingController();
  TextEditingController waistText = TextEditingController();
  TextEditingController waistFromNeckText = TextEditingController();
  TextEditingController chestFromNeckText = TextEditingController();
  TextEditingController hipsText = TextEditingController();

  int heightUnitIndex = 0;
  int weightUnitIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.action == 'update') {
      heightText.text = widget.height!;
      weightText.text = widget.weight!;
      totalText.text = widget.total!;
      shoulderText.text = widget.shoulder!;
      chestText.text = widget.chest!;
      sleevesText.text = widget.sleeves!;
      waistText.text = widget.waist!;
      waistFromNeckText.text = widget.waistFromNeck!;
      chestFromNeckText.text = widget.chestFromNeck!;
      hipsText.text = widget.hips!;
      setState(() {
        upperValue = widget.upperValue ?? 0;
        lowerValue = widget.lowerValue ?? 0;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    heightText.dispose();
    weightText.dispose();
    totalText.dispose();
    shoulderText.dispose();
    chestText.dispose();
    sleevesText.dispose();
    waistText.dispose();
    waistFromNeckText.dispose();
    chestFromNeckText.dispose();
    hipsText.dispose();
  }

  Widget rowInputFields(
      name1, name2, TextEditingController controller1, TextEditingController controller2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name1,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: controller1,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Inches',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name2,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: controller2,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Inches',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  checkFields() {
    if (heightText.text == '' ||
        weightText.text == '' ||
        totalText.text == '' ||
        shoulderText.text == '' ||
        chestText.text == '' ||
        sleevesText.text == '' ||
        waistText.text == '' ||
        waistFromNeckText.text == '' ||
        chestFromNeckText.text == '' ||
        hipsText.text == '') {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 18,
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: heightText,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Height',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    ToggleSwitch(
                      initialLabelIndex: 0,
                      minHeight: 35,
                      minWidth: 55,
                      totalSwitches: 2,
                      fontSize: 18,
                      inactiveBgColor: Colors.white38,
                      labels: heightArr,
                      onToggle: (index) {
                        setState(() {
                          heightUnitIndex = index;
                        });
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: weightText,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Weight',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    ToggleSwitch(
                      initialLabelIndex: 0,
                      minHeight: 35,
                      minWidth: 55,
                      totalSwitches: 2,
                      fontSize: 18,
                      inactiveBgColor: Colors.white38,
                      labels: weightArr,
                      onToggle: (index) {
                        setState(() {
                          weightUnitIndex = index;
                        });
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Upper Body Fit Preference',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                    SfSliderTheme(
                      data: SfSliderThemeData(
                        tooltipBackgroundColor: ThemeColors.primaryColorLight,
                        tooltipTextStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 10,
                        ),
                      ),
                      child: SfSlider(
                        activeColor: ThemeColors.primaryColorLight,
                        min: 0.0,
                        max: 100.0,
                        interval: 10,
                        showTicks: true,
                        showLabels: false,
                        enableTooltip: true,
                        shouldAlwaysShowTooltip: true,
                        tooltipShape: const SfPaddleTooltipShape(),
                        value: upperValue,
                        onChanged: (dynamic newValue) {
                          setState(() {
                            upperValue = newValue;
                          });
                        },
                      ),
                    ),
                    const Text(
                      'Lower Body Fit Preference',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                    SfSliderTheme(
                      data: SfSliderThemeData(
                        tooltipBackgroundColor: ThemeColors.primaryColorLight,
                        tooltipTextStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 10,
                        ),
                      ),
                      child: SfSlider(
                        activeColor: ThemeColors.primaryColorLight,
                        min: 0.0,
                        max: 100.0,
                        interval: 10,
                        showTicks: true,
                        showLabels: false,
                        enableTooltip: true,
                        shouldAlwaysShowTooltip: true,
                        tooltipShape: const SfPaddleTooltipShape(),
                        value: lowerValue,
                        onChanged: (dynamic newValue) {
                          setState(() {
                            lowerValue = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Custom Size',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    rowInputFields(
                      'Total Length',
                      'Shoulder Width',
                      totalText,
                      shoulderText,
                    ),
                    rowInputFields(
                      'Chest',
                      'Sleeves from Neck',
                      chestText,
                      sleevesText,
                    ),
                    rowInputFields(
                      'Waist',
                      'Waist from Neck',
                      waistText,
                      waistFromNeckText,
                    ),
                    rowInputFields(
                      'Chest from Neck',
                      'Hips',
                      chestFromNeckText,
                      hipsText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
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
                bool res = checkFields();
                if (res) {
                  loadingDialog(context, asset: AssetConstants.loadingLottie);
                  if (widget.action == 'add') {
                    addSizingProfile(
                      heightText.text,
                      heightArr[heightUnitIndex],
                      weightText.text,
                      weightArr[weightUnitIndex],
                      upperValue,
                      lowerValue,
                      totalText.text,
                      shoulderText.text,
                      chestText.text,
                      sleevesText.text,
                      waistText.text,
                      waistFromNeckText.text,
                      chestFromNeckText.text,
                      hipsText.text,
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    await updateSizingProfile(
                      heightText.text,
                      heightArr[heightUnitIndex],
                      weightText.text,
                      weightArr[weightUnitIndex],
                      upperValue,
                      lowerValue,
                      totalText.text,
                      shoulderText.text,
                      chestText.text,
                      sleevesText.text,
                      waistText.text,
                      waistFromNeckText.text,
                      chestFromNeckText.text,
                      hipsText.text,
                      widget.id,
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                } else {
                  displayToast(
                    context,
                    title: 'All fields are mandatory.',
                    desc: 'Please fill all fields.',
                  );
                }
                widget.onFunctionComplete();
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
                'Next',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
