import 'package:dropout/controllers/post/watch_videos_controller.dart';
import 'package:dropout/screens/reuseable_widgets/post_list.dart';
import '../../helper/imports/common_import.dart';

class WatchVideos extends StatefulWidget {
  const WatchVideos({super.key});

  @override
  State<WatchVideos> createState() => _WatchVideosState();
}

class _WatchVideosState extends State<WatchVideos> {
  @override
  void initState() {
    Get.put(WatchVideosController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(
        children: [
          titleNavigationBar(title: videosString),
          Expanded(
            child: PostList(
              postSource: PostSource.videos,
            ),
          ),
        ],
      ),
    );
  }
}
