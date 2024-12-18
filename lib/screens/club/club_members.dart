import 'package:dropout/helper/imports/club_imports.dart';
import 'package:dropout/helper/imports/common_import.dart';
import '../../components/user_card.dart';
import '../profile/other_user_profile.dart';

class ClubMembers extends StatefulWidget {
  final ClubModel club;

  const ClubMembers({super.key, required this.club});

  @override
  ClubMembersState createState() => ClubMembersState();
}

class ClubMembersState extends State<ClubMembers> {
  final ClubsController _clubsController = Get.find();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    _clubsController.getMembers(clubId: widget.club.id);
  }

  @override
  void didUpdateWidget(covariant ClubMembers oldWidget) {
    loadData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _clubsController.clearMembers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: AppColorConstants.backgroundColor,
        body: Column(
          children: [
            backNavigationBar(title: clubMembersString.tr),
            Expanded(
              child: GetBuilder<ClubsController>(
                  init: _clubsController,
                  builder: (ctx) {
                    ScrollController scrollController = ScrollController();
                    scrollController.addListener(() {
                      if (scrollController.position.maxScrollExtent ==
                          scrollController.position.pixels) {
                        if (!_clubsController
                            .membersDataWrapper.isLoading.value) {
                          _clubsController.getMembers(clubId: widget.club.id!);
                        }
                      }
                    });

                    List<ClubMemberModel> membersList =
                        _clubsController.members;
                    return _clubsController.membersDataWrapper.isLoading.value
                        ? const ShimmerUsers()
                            .hp(DesignConstants.horizontalPadding)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              membersList.isEmpty
                                  ? noUserFound(context)
                                  : Expanded(
                                      child: ListView.separated(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 50),
                                        controller: scrollController,
                                        itemCount: membersList.length,
                                        itemBuilder: (context, index) {
                                          return widget.club.amIAdmin
                                              ? ClubMemberTile(
                                                  member: membersList[index],
                                                  viewCallback: () {
                                                    Get.to(() => OtherUserProfile(
                                                            userId: membersList[
                                                                    index]
                                                                .id))!
                                                        .then((value) =>
                                                            {loadData()});
                                                  },
                                                  removeBtnCallback: () {
                                                    removeMemberBtnClicked(
                                                        membersList[index]);
                                                  },
                                                )
                                              : ClubMemberTile(
                                                  member: membersList[index],
                                                  viewCallback: () {
                                                    Get.to(() => OtherUserProfile(
                                                            userId: membersList[
                                                                    index]
                                                                .id))!
                                                        .then((value) =>
                                                            {loadData()});
                                                  },
                                                );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 20,
                                          );
                                        },
                                      ).hp(DesignConstants.horizontalPadding),
                                    ),
                            ],
                          );
                  }),
            ),
          ],
        ));
  }

  removeMemberBtnClicked(ClubMemberModel member) {
    _clubsController.removeMemberFromClub(widget.club, member);
  }
}
