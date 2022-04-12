import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/influencer_list_model.dart';
import 'package:syzee/services/influencer_services.dart';
import 'package:syzee/ui/screen/story_screen.dart';

class HomeTabInfluencerStories extends StatefulWidget {
  const HomeTabInfluencerStories({Key? key}) : super(key: key);

  @override
  State<HomeTabInfluencerStories> createState() =>
      _HomeTabInfluencerStoriesState();
}

class _HomeTabInfluencerStoriesState extends State<HomeTabInfluencerStories> {
  late var influencer;

  @override
  void initState() {
    super.initState();
    influencer = getListOfInfluencer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: influencer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          InfluencerList list = snapshot.data as InfluencerList;
          return list.data.isEmpty
              ? const Text(
                  'No influencer stories found.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                )
              : SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoryScreen(
                                id: list.data[index].id,
                                name: list.data[index].name,
                                profileImage: '${AssetConstants.mockImageLink}/influencer_profile/${list.data[index].image}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                          child: Image.network(
                            '${AssetConstants.mockImageLink}/influencer_profile/${list.data[index].image}',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                      height: 76,
                      width: 67,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
