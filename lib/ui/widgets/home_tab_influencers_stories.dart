import 'package:flutter/material.dart';

class HomeTabInfluencerStories extends StatelessWidget {
  const HomeTabInfluencerStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Image.asset(
              'assets/images/home/home_tab/influencer1.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Image.asset(
              'assets/images/home/home_tab/influencer2.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Image.asset(
              'assets/images/home/home_tab/influencer1.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
