import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/global/tools.dart';
import 'package:syzee/models/address_model.dart';
import 'package:syzee/services/address_service.dart';
import 'package:syzee/ui/widgets/manage_address_card.dart';
import 'package:syzee/ui/widgets/update_or_add_address.dart';

class ManageAddress extends StatefulWidget {
  const ManageAddress({Key? key}) : super(key: key);

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  late Future<AddressModel> address;

  @override
  void initState() {
    super.initState();
    address = getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Manage Address',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                color: Color(0xff009C95),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: address,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AddressModel addressData = snapshot.data as AddressModel;
                  return addressData.data.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Lottie.asset(
                              AssetConstants.addressEmpty,
                              repeat: true,
                            ),
                            const Text(
                              'Add an address and get started',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: addressData.data.length,
                          itemBuilder: (context, index) {
                            return ManageAddressCard(
                              code: addressData.data[index].code,
                              type: addressData.data[index].type,
                              name: addressData.data[index].name,
                              phone: addressData.data[index].phone,
                              address:
                                  '${addressData.data[index].doorNo}, ${addressData.data[index].buildingNo}, ${addressData.data[index].street}, ${addressData.data[index].zone}, ${addressData.data[index].country}',
                              onEdit: () {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 4,
                                              width: 80,
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 25,
                                              ),
                                              decoration: const BoxDecoration(
                                                color: Colors.blueGrey,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                              ),
                                            ),
                                            UpdateOrAddAddress(
                                              action: 'update',
                                              id: addressData.data[index].id.toString(),
                                              name:
                                                  addressData.data[index].name,
                                              code:
                                                  addressData.data[index].code,
                                              phone:
                                                  addressData.data[index].phone,
                                              type:
                                                  addressData.data[index].type,
                                              doorNo: addressData
                                                  .data[index].doorNo,
                                              buildingNo: addressData
                                                  .data[index].buildingNo,
                                              street: addressData
                                                  .data[index].street,
                                              zone:
                                                  addressData.data[index].zone,
                                              country: addressData
                                                  .data[index].country,
                                              onActionComplete: () {
                                                setState(() {
                                                  address = getAddress();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              onDelete: () async {
                                loadingDialog(context, asset: AssetConstants.loadingLottie);
                                var result = await deleteAddress(addressData.data[index].id);
                                setState(() {
                                  address = getAddress();
                                  Navigator.pop(context);
                                });
                              },
                            );
                          },
                        );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Lottie.asset(
                        AssetConstants.loadingLottie,
                        repeat: true,
                      ),
                      const Text(
                        'Loading',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 35,
              ).copyWith(bottom: 22),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      Scaffold.of(context).showBottomSheet<void>(
                        (BuildContext context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: 4,
                                    width: 80,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 25,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                  UpdateOrAddAddress(
                                    action: 'add',
                                    onActionComplete: () {
                                      setState(() {
                                        address = getAddress();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
                      'Add Address',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(
                  AssetConstants.addressEmpty,
                  repeat: true,
                ),
                const Text(
                  'Add an address and get started',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
 */
