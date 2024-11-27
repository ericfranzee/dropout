import 'dart:async';
import 'package:dropout/api_handler/apis/chat_api.dart';
import 'package:dropout/controllers/chat_and_call/chat_detail_controller.dart';
import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/screens/chat/chat_detail.dart';

class RandomChatAndCallController extends GetxController {
  final ChatDetailController _chatDetailController = Get.find();

  Rx<UserModel?> randomOnlineUser = Rx<UserModel?>(null);
  bool stopSearching = false;

  clear() {
    randomOnlineUser.value = null;
    stopSearching = true;
  }

  getRandomOnlineUsers({bool? startFresh, int? profileCategoryType}) {
    if (startFresh == true) {
      stopSearching = false;
    }
    if (stopSearching == false) {
      ChatApi.getRandomOnlineUsers(profileCategoryType,
          resultCallback: (result) {
        Timer(const Duration(seconds: 2), () {
          result.shuffle();

          _chatDetailController.getChatRoomWithUser(
              userId: result.first.id,
              callback: (room) {
                Loader.dismiss();

                Get.close(1);
                Get.to(() => ChatDetail(
                      // opponent: usersList[index - 1].toChatRoomMember,
                      chatRoom: room,
                    ));
              });
        });
      });
    }
  }
}
