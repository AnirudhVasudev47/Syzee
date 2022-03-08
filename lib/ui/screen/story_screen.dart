import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/influencer_story_model.dart';
import 'package:syzee/services/influencer_services.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key, required this.profileImage, required this.name, required this.id}) : super(key: key);

  final String profileImage;
  final String name;
  final int id;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  String? when = "";

  var stories;

  @override
  void initState() {
    super.initState();
    stories = getInfluencerStory(widget.id);
  }

  Widget _buildProfileView() {
    return Container(
      height: 55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 55,
            width: 55,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.network(
              widget.profileImage,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  when!,
                  style: const TextStyle(
                    color: Colors.white38,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: stories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            InfluencerStoryModel story = snapshot.data as InfluencerStoryModel;
            return Stack(
              children: [
                StoryView(
                  onStoryShow: (str) {

                  },
                  onComplete: () {
                    Navigator.pop(context);
                  },
                  onVerticalSwipeComplete: (dir) {
                    if (dir == Direction.down) {
                      Navigator.pop(context);
                    }
                  },
                  storyItems: story.data
                      .map(
                        (item) => StoryItem.pageImage(
                          url: '${AssetConstants.mockImageLink}/influencer_story/${item.storiesImages}',
                          controller: controller,
                        ),
                      )
                      .toList(),
                  controller: controller,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ).copyWith(top: 55),
                  child: _buildProfileView(),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

/*
[
                    StoryItem.pageImage(
                      url:
                      'https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                      controller: controller,
                      caption: 'Test',
                    ),
                    StoryItem.pageImage(
                      url:
                      'https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                      controller: controller,
                      caption: 'Test',
                    ),
                    StoryItem.pageImage(
                      url:
                      'https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                      controller: controller,
                      caption: 'Test',
                    ),
                  ]
 */