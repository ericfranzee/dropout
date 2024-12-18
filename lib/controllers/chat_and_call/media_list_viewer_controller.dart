import 'package:get/get.dart';
import 'package:dropout/helper/imports/chat_imports.dart';

import '../../manager/db_manager_realm.dart';

class MediaListViewerController extends GetxController {
  int currentIndex = 0;
  RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;

  clear() {
    messages.clear();
  }

  setMessages(List<ChatMessageModel> messagesList) {
    messages.value = messagesList;
    update();
  }

  setCurrentMediaIndex(int index) {
    currentIndex = index;
  }

  deleteMessage({required ChatRoomModel inChatRoom}) async {
    ChatMessageModel messageToDelete = messages[currentIndex];

    // remove saved media
    getIt<FileManager>().deleteMessageMedia(messageToDelete);

    // remove message in local database
    await getIt<RealmDBManager>()
        .softDeleteMessages(messagesToDelete: [messageToDelete]);
    messages.removeAt(currentIndex);
    if (messages.isEmpty) {
      Get.back();
    } else {
      update();
    }
  }
}
