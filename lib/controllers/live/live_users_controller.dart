import 'package:dropout/api_handler/apis/live_streaming_api.dart';
import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/helper/list_extension.dart';
import 'package:dropout/model/data_wrapper.dart';
import 'package:dropout/model/live_model.dart';

class LiveUserController extends GetxController {
  RxList<UserLiveCallDetail> liveStreamUser = <UserLiveCallDetail>[].obs;

  DataWrapper liveUserDataWrapper = DataWrapper();

  clear() {
    liveStreamUser.clear();
    liveUserDataWrapper = DataWrapper();
  }

  loadMore(VoidCallback callback) {
    if (liveUserDataWrapper.haveMoreData.value) {
      getLiveUsers(callback);
    } else {
      callback();
    }
  }

  // fetch live users
  void getLiveUsers(VoidCallback callback) async {
    liveUserDataWrapper.isLoading.value = true;

    LiveStreamingApi.getAllLiveUsers(
        page: liveUserDataWrapper.page,
        resultCallback: (result, metadata) {
          liveStreamUser.addAll(result);
          liveStreamUser.unique((e) => e.id);
          liveUserDataWrapper.processCompletedWithData(metadata);

          callback();
        });
  }

  getLiveDetail(
      {required String channelName,
      required Function(LiveModel) resultCallback}) {
    LiveStreamingApi.getLiveDetail(
        channelName: channelName,
        resultCallback: (result) {
          resultCallback(result);
        });
  }
}
