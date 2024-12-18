import 'package:dropout/components/job/job_card.dart';
import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/helper/imports/models.dart';
import 'package:dropout/screens/jobs_listing/job_detail.dart';

class JobPostTile extends StatefulWidget {
  final PostModel post;
  final bool isResharedPost;

  const JobPostTile(
      {super.key, required this.post, required this.isResharedPost});

  @override
  State<JobPostTile> createState() => _JobPostTileState();
}

class _JobPostTileState extends State<JobPostTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return JobCard(job: widget.post.job!).ripple(() {
      Get.to(() => JobDetail(job: widget.post.job!));
    });
  }
}
