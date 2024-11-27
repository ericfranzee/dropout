import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/helper/imports/models.dart';

class EventPostTile extends StatefulWidget {
  final PostModel post;
  final bool isResharedPost;

  const EventPostTile(
      {Key? key, required this.post, required this.isResharedPost})
      : super(key: key);

  @override
  State<EventPostTile> createState() => _EventPostTileState();
}

class _EventPostTileState extends State<EventPostTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.post.event!.image,
      fit: BoxFit.cover,
    );
  }
}
