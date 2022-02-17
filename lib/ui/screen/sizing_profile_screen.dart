import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/models/sizing_profile_model.dart';
import 'package:syzee/services/sizing_service.dart';
import 'package:syzee/ui/widgets/sizing_profile_card.dart';
import 'package:syzee/ui/widgets/update_or_add_size.dart';

class SizingProfileScreen extends StatefulWidget {
  const SizingProfileScreen({Key? key}) : super(key: key);

  @override
  State<SizingProfileScreen> createState() => _SizingProfileScreenState();
}

class _SizingProfileScreenState extends State<SizingProfileScreen> {
  late Future<SizingProfileModel> sizing;

  @override
  void initState() {
    super.initState();

    sizing = getAllSizingProfile();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Saved Sizes',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              color: Color(0xff009C95),
            ),
            textAlign: TextAlign.center,
          ),
          FutureBuilder(
            future: sizing,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                SizingProfileModel size = snapshot.data as SizingProfileModel;
                return size.data.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Lottie.asset(
                            AssetConstants.sizeEmpty,
                            repeat: true,
                          ),
                          const Text(
                            'Add a size and get started',
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
                        itemCount: size.data.length,
                        itemBuilder: (context, index) {
                          return SizingProfileCard(
                            heightUnit: size.data[index].heightUnit,
                            height: size.data[index].height,
                            weight: size.data[index].weight,
                            weightUnit: size.data[index].weightUnit,
                            selectedId: size.selectedId.toString(),
                            id: size.data[index].id.toString(),
                            onTapCard: () {},
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
                                          UpdateOrAddSize(
                                            action: 'update',
                                            height: size.data[index].height,
                                            weight: size.data[index].weight,
                                            total: size.data[index].length,
                                            shoulder: size.data[index].width,
                                            chest: size.data[index].chest,
                                            sleeves: size.data[index].sleevesFromNeck,
                                            waist: size.data[index].waist,
                                            waistFromNeck: size.data[index].waistFromNeck,
                                            chestFromNeck: size.data[index].chestFromNeck,
                                            hips: size.data[index].hips,
                                            upperValue: double.parse(size.data[index].upperBody),
                                            lowerValue: double.parse(size.data[index].lowerBody),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 4,
                                  width: 80,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 150,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 75,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                                // const UpdateOrAddSize(
                                //   action: 'add',
                                // ),
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
                    'Add Size Profile',
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
    );
  }
}
