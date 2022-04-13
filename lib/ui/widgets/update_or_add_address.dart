import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/services/address_service.dart';

enum AddressType { home, office, other }

class UpdateOrAddAddress extends StatefulWidget {
  const UpdateOrAddAddress({
    Key? key,
    required this.action,
    this.name,
    this.type,
    this.code,
    this.phone,
    this.doorNo,
    this.buildingNo,
    this.street,
    this.zone,
    this.country,
    required this.onActionComplete,
    this.id,
  }) : super(key: key);

  final String action;
  final String? id;
  final String? name;
  final String? type;
  final String? code;
  final String? phone;
  final String? doorNo;
  final String? buildingNo;
  final String? street;
  final String? zone;
  final String? country;
  final VoidCallback onActionComplete;

  @override
  State<UpdateOrAddAddress> createState() => _UpdateOrAddAddressState();
}

class _UpdateOrAddAddressState extends State<UpdateOrAddAddress> {
  bool isQatar = true;
  String country = 'Qatar';
  Country selectedCountry = Country.parse('Qatar');
  AddressType _type = AddressType.home;

  TextEditingController nameText = TextEditingController();
  TextEditingController mobileText = TextEditingController();
  TextEditingController buildingNoText = TextEditingController();
  TextEditingController zoneText = TextEditingController();
  TextEditingController streetText = TextEditingController();
  TextEditingController doorText = TextEditingController();

  TextEditingController street1Text = TextEditingController();
  TextEditingController street2Text = TextEditingController();
  TextEditingController cityText = TextEditingController();
  TextEditingController stateText = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.action == 'update') {
      if (widget.country!.toLowerCase() == 'qatar') {
        nameText.text = widget.name!;
        mobileText.text = widget.phone!;
        try {
          selectedCountry = Country.parse(widget.country ?? 'qatar');
        } catch (e) {
          selectedCountry = Country.parse('qatar');
        }
        doorText.text = widget.doorNo!;
        buildingNoText.text = widget.buildingNo!;
        zoneText.text = widget.zone!;
        streetText.text = widget.street!;
        setState(() {
          country = selectedCountry.name;
          isQatar = selectedCountry.name.toLowerCase() == 'qatar';
        });
      } else {
        nameText.text = widget.name!;
        mobileText.text = widget.phone!;
        selectedCountry = Country.parse(widget.country ?? 'qatar');
        street1Text.text = widget.doorNo!;
        street2Text.text = widget.buildingNo!;
        stateText.text = widget.zone!;
        cityText.text = widget.street!;
        setState(() {
          country = selectedCountry.name;
          isQatar = selectedCountry.name.toLowerCase() == 'qatar';
        });
      }
    }
  }

  bool checkFields() {
    if (country == 'Qatar') {
      if (nameText.text == '' ||
          mobileText.text == '' ||
          buildingNoText.text == '' ||
          zoneText.text == '' ||
          streetText.text == '' ||
          doorText.text == '') {
        return false;
      }
    } else {
      if (nameText.text == '' ||
          mobileText.text == '' ||
          street1Text.text == '' ||
          street2Text.text == '' ||
          cityText.text == '' ||
          stateText.text == '') {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();

    nameText.dispose();
    mobileText.dispose();
    buildingNoText.dispose();
    zoneText.dispose();
    streetText.dispose();
    doorText.dispose();

    street1Text.dispose();
    street2Text.dispose();
    cityText.dispose();
    stateText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 18,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Name*',
            style: TextStyle(
              fontFamily: 'VarelaRound',
              fontSize: 13,
              color: Color(0xff7F7F7F),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: nameText,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        const Divider(
          color: Color(0xffDDDDDD),
          indent: 25,
          endIndent: 25,
          thickness: 1.5,
          height: 1.5,
        ),
        const SizedBox(
          height: 18,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Mobile Number*',
            style: TextStyle(
              fontFamily: 'VarelaRound',
              fontSize: 13,
              color: Color(0xff7F7F7F),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: mobileText,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        const Divider(
          color: Color(0xffDDDDDD),
          indent: 25,
          endIndent: 25,
          thickness: 1.5,
          height: 1.5,
        ),
        const SizedBox(
          height: 18,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Select country*',
            style: TextStyle(
              fontFamily: 'VarelaRound',
              fontSize: 13,
              color: Color(0xff7F7F7F),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              // optional. Shows phone code before the country name.
              onSelect: (Country co) {
                setState(() {
                  country = co.name;
                  selectedCountry = co;
                  isQatar = co.name.toLowerCase() == 'qatar';
                });
              },
            );
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ).copyWith(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  country,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 17,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 30,
                )
              ],
            ),
          ),
        ),
        const Divider(
          color: Color(0xffDDDDDD),
          indent: 25,
          endIndent: 25,
          thickness: 1.5,
          height: 1.5,
        ),
        const SizedBox(
          height: 18,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Name*',
            style: TextStyle(
              fontFamily: 'VarelaRound',
              fontSize: 13,
              color: Color(0xff7F7F7F),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  setState(() {
                    _type = AddressType.home;
                  });
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
                leading: Radio(
                  value: AddressType.home,
                  groupValue: _type,
                  onChanged: (AddressType? value) {
                    setState(() {
                      _type = value!;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  setState(() {
                    _type = AddressType.office;
                  });
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                title: const Text(
                  'Office',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
                leading: Radio(
                  value: AddressType.office,
                  groupValue: _type,
                  onChanged: (AddressType? value) {
                    setState(() {
                      _type = value!;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                horizontalTitleGap: 0,
                onTap: () {
                  setState(() {
                    _type = AddressType.other;
                  });
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                title: const Text(
                  'Other',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
                leading: Radio(
                  value: AddressType.other,
                  groupValue: _type,
                  onChanged: (AddressType? value) {
                    setState(() {
                      _type = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        country == 'Qatar'
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      decoration: const BoxDecoration(
                          color: Color(0xff00A3AB),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Building No',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'لا للبناء',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextField(
                              controller: buildingNoText,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Zone',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'منطقة',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 5,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: zoneText,
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Street',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'شارع',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 5,
                                      ),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: TextField(
                                        controller: streetText,
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                        ),
                                        decoration: const InputDecoration(
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
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 55),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Door No.',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'رقم الباب',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 5,
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: TextField(
                                    controller: doorText,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                    decoration: const InputDecoration(
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
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Street 1*',
                            style: TextStyle(
                              fontFamily: 'VarelaRound',
                              fontSize: 13,
                              color: Color(0xff7F7F7F),
                            ),
                          ),
                          TextField(
                            controller: street1Text,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff169B93),
                                  width: 1,
                                ),
                              ),
                              hintText: 'Street 1',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            'Street 2*',
                            style: TextStyle(
                              fontFamily: 'VarelaRound',
                              fontSize: 13,
                              color: Color(0xff7F7F7F),
                            ),
                          ),
                          TextField(
                            controller: street2Text,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff169B93),
                                  width: 1,
                                ),
                              ),
                              hintText: 'Street 2',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            'City',
                            style: TextStyle(
                              fontFamily: 'VarelaRound',
                              fontSize: 13,
                              color: Color(0xff7F7F7F),
                            ),
                          ),
                          TextField(
                            controller: cityText,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff169B93),
                                  width: 1,
                                ),
                              ),
                              hintText: 'City',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            'State*',
                            style: TextStyle(
                              fontFamily: 'VarelaRound',
                              fontSize: 13,
                              color: Color(0xff7F7F7F),
                            ),
                          ),
                          TextField(
                            controller: stateText,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff169B93),
                                  width: 1,
                                ),
                              ),
                              hintText: 'State',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
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
                bool checkRes = checkFields();
                if (checkRes) {
                  loadingDialog(context, asset: AssetConstants.loadingLottie);
                  if (widget.action == 'add') {
                    if (country == 'Qatar') {
                      // Add Qatar
                      await addAddress(
                        nameText.text,
                        '+${selectedCountry.phoneCode}',
                        mobileText.text,
                        doorText.text,
                        buildingNoText.text,
                        streetText.text,
                        zoneText.text,
                        country,
                        _type == AddressType.home
                            ? 'Home'
                            : _type == AddressType.office
                                ? 'Office'
                                : 'Other',
                      );
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    } else {
                      // Add other country
                      await addAddress(
                        nameText.text,
                        '+${selectedCountry.phoneCode}',
                        mobileText.text,
                        street1Text.text,
                        street2Text.text,
                        cityText.text,
                        stateText.text,
                        country,
                        _type == AddressType.home
                            ? 'Home'
                            : _type == AddressType.office
                                ? 'Office'
                                : 'Other',
                      );
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }
                  } else {
                    if (isQatar) {
                      // Update Qatar
                      await updateAddress(
                        widget.id,
                        nameText.text,
                        '+${selectedCountry.phoneCode}',
                        mobileText.text,
                        doorText.text,
                        buildingNoText.text,
                        streetText.text,
                        zoneText.text,
                        country,
                        _type == AddressType.home
                            ? 'Home'
                            : _type == AddressType.office
                                ? 'Office'
                                : 'Other',
                      );
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    } else {
                      // Update other country
                      await updateAddress(
                        widget.id,
                        nameText.text,
                        '+${selectedCountry.phoneCode}',
                        mobileText.text,
                        street1Text.text,
                        street2Text.text,
                        cityText.text,
                        stateText.text,
                        country,
                        _type == AddressType.home
                            ? 'Home'
                            : _type == AddressType.office
                                ? 'Office'
                                : 'Other',
                      );
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }
                  }
                } else {
                  displayToast(
                    context,
                    title: 'Please fill all the fields',
                    desc: 'Please check and fill all the fields to continue.',
                  );
                }
                widget.onActionComplete();
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
