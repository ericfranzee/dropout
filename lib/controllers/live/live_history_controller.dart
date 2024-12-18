import 'package:dropout/api_handler/apis/live_streaming_api.dart';
import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/model/live_model.dart';
import 'package:get/get.dart';
import 'package:dropout/helper/list_extension.dart';

class LiveHistoryController extends GetxController {
  RxList<LiveModel> lives = <LiveModel>[].obs;

  bool isLoading = false;
  int currentPage = 1;
  bool canLoadMore = true;

  clear() {
    isLoading = false;
    currentPage = 1;
    canLoadMore = true;
  }

  getLiveHistory() {
    if (canLoadMore == true) {
      isLoading = true;

      LiveStreamingApi.getLiveHistory(
          page: currentPage,
          resultCallback: (result, metadata) {
            lives.addAll(result);
            lives.unique((e)=> e.id);

            isLoading = false;
            currentPage += 1;
            canLoadMore = result.length >= metadata.perPage;

            update();
          });
    }
  }
}
