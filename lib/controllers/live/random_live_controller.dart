// import 'package:dropout/api_handler/api_controller.dart';
// import 'package:dropout/api_handler/apis/live_streaming_api.dart';
// import 'package:dropout/helper/imports/common_import.dart';
// import 'package:dropout/model/user_model.dart';
// import 'package:get/get.dart';
//
// class RandomLivesController extends GetxController {
//   RxList<UserModel> randomUsers = <UserModel>[].obs;
//
//   int page = 1;
//   bool canLoadMore = true;
//
//   clear() {
//     randomUsers.clear();
//     canLoadMore = true;
//     page = 1;
//   }
//
//   // getAllRandomLives() {
//   //   if (canLoadMore) {
//   //     LiveStreamingApi.getRandomLiveUsers(resultCallback: (result, metadata) {
//   //       randomUsers.addAll(result);
//   //       randomUsers.refresh();
//   //
//   //       page += 1;
//   //       if (result.length == metadata.perPage) {
//   //         canLoadMore = true;
//   //       } else {
//   //         canLoadMore = false;
//   //       }
//   //     });
//   //   }
//   // }
// }
