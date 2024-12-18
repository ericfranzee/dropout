import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/screens/tvs/tv_channel_detail.dart';
import 'package:dropout/model/live_tv_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/tv/live_tv_streaming_controller.dart';

class FavTvList extends StatefulWidget {
  const FavTvList({Key? key}) : super(key: key);

  @override
  State<FavTvList> createState() => _FavTvListState();
}

class _FavTvListState extends State<FavTvList> {
  final TvStreamingController _tvStreamingController = Get.find();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tvStreamingController.clearTvs();
      loadData();
    });
    super.initState();
  }

  loadData() {
    _tvStreamingController.getFavTvs();
  }

  @override
  void dispose() {
    _tvStreamingController.clearTvs();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: AppColorConstants.backgroundColor,
        body: Column(
          children: [

            backNavigationBar(title: favouriteString),
            Expanded(child: tvList()),
          ],
        ));
  }

  Widget tvList() {
    return GetBuilder<TvStreamingController>(
        init: _tvStreamingController,
        builder: (ctx) {
          return _tvStreamingController.isLoadingFavTvs
              ? SizedBox(
                  height: (Get.height / 1.5),
                  width: (Get.width),
                  child: const Center(child: CircularProgressIndicator()))
              : _tvStreamingController.tvs.isEmpty
                  ? emptyData(title: noDataString, subTitle: '')
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        mainAxisExtent: 140,
                      ),
                      itemCount: _tvStreamingController.tvs.length,
                      itemBuilder: (BuildContext context, int index) {
                        TvModel tvModel = _tvStreamingController.tvs[index];
                        return Card(
                            margin: const EdgeInsets.all(1),
                            child: CachedNetworkImage(
                              imageUrl: tvModel.image,
                              fit: BoxFit.fitHeight,
                              height: 230,
                            ).round(10).ripple(() {
                              Get.to(() => TVChannelDetail(
                                    tvModel: tvModel,
                                  ));
                            })).round(5);
                      },
                    ).addPullToRefresh(
                      refreshController: _refreshController,
                      onRefresh: () {},
                      onLoading: () {
                        loadData();
                      },
                      enablePullUp: true,
                      enablePullDown: false);
        });
  }
}
