import 'dart:io';
import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:dropout/helper/imports/common_import.dart';
import 'package:video_player/video_player.dart';

import '../../components/post_card/video_widget.dart';
import '../../manager/file_manager.dart';
import '../../model/chat_message_model.dart';
import '../../model/post_gallery.dart';

// class VideoPlayerScreen extends StatefulWidget {
//   final PostGallery? media;
//   final ChatMessageModel? chatMessage;
//
//   const VideoPlayerScreen({Key? key, this.media, this.chatMessage})
//       : super(key: key);
//
//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     String videoPath = '';
//     if (widget.media != null) {
//       videoPath = widget.media!.filePath;
//     } else {
//       videoPath = widget.chatMessage!.mediaContent.video!;
//     }
//
//     _controller = VideoPlayerController.network(videoPath)
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//         backgroundColor: ColorConstants.backgroundColor,
//         body: Column(
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ThemeIconWidget(
//                   ThemeIcon.backArrow,
//                   size: 20,
//                 ).ripple(() {
//                   Get.back();
//                 }),
//               ],
//             ).hp(DesignConstants.horizontalPadding),
//             divider().vP8,
//             Expanded(
//               child: Center(
//                 child: _controller.value.isInitialized
//                     ? AspectRatio(
//                         aspectRatio: _controller.value.aspectRatio,
//                         child: VideoPlayer(_controller),
//                       )
//                     : Container(),
//               ),
//             ),
//           ],
//         ));
//   }
// }

class PlayVideoController extends StatefulWidget {
  final PostGallery? media;
  final ChatMessageModel? chatMessage;

  const PlayVideoController({Key? key, this.media, this.chatMessage})
      : super(key: key);

  @override
  State<PlayVideoController> createState() => _PlayVideoControllerState();
}

class _PlayVideoControllerState extends State<PlayVideoController> {
  // final VideoPostTileController videoPostTileController = Get.find();
  Future<void>? initializeVideoPlayerFuture;
  VideoPlayerController? videoPlayerController;
  bool isPlayed = false;
  bool playVideo = true;

  @override
  void initState() {
    super.initState();

    // if (widget.media != null) {
    //   videoPath = widget.media!.filePath;
    // } else {
    //   videoPath = widget.chatMessage!.mediaContent.video!;
    // }
    //
    // _controller = VideoPlayerController.network(videoPath)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    loadVideo();
  }

  loadVideo() async {
    String? path =
        await getIt<FileManager>().localFilePathForMessage(widget.chatMessage!);

    if (path != null) {
      prepareVideo(url: path, isLocalFile: true);
    } else {
      prepareVideo(
          url: widget.chatMessage!.mediaContent.video!, isLocalFile: false);
    }
  }

  @override
  void didUpdateWidget(covariant PlayVideoController oldWidget) {
    loadVideo();

    // if (playVideo == true) {
    play();
    // } else {
    //   pause();
    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // print('VideoPostTileState dispose');
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(
        children: [

          backNavigationBar( title: ''),
          divider().tP16,
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  FutureBuilder(
                    future: initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Stack(
                          children: [
                            Container(
                              key: PageStorageKey(
                                  widget.chatMessage!.mediaContent.video!),
                              child: Chewie(
                                key: PageStorageKey(
                                    widget.chatMessage!.mediaContent.video!),
                                controller: ChewieController(
                                  videoPlayerController: videoPlayerController!,
                                  aspectRatio:
                                      videoPlayerController!.value.aspectRatio,
                                  showControls: false,
                                  // Prepare the video to be played and display the first frame
                                  autoInitialize: true,
                                  looping: false,
                                  autoPlay: false,

                                  allowMuting: true,
                                  // Errors can occur for example when trying to play a video
                                  // from a non-existent URL
                                  errorBuilder: (context, errorMessage) {
                                    return Center(
                                      child: Text(
                                        errorMessage,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),

                  isPlayed == true || playVideo == false
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: 0,
                          child: Container(
                            height: min(
                                (Get.width - 32) /
                                    videoPlayerController!.value.aspectRatio,
                                Get.height * 0.5),
                            color: Colors.black38,
                            child: ThemeIconWidget(
                              ThemeIcon.play,
                              size: 50,
                              color: Colors.white,
                            ),
                          ).ripple(() {
                            play();
                          }))
                      : Container(),
                  // Positioned(
                  //     right: 10,
                  //     bottom: 10,
                  //     child: Container(
                  //       height: 25,
                  //       width: 25,
                  //       color: Colors.black38,
                  //       child: ThemeIconWidget(
                  //         ThemeIcon.fullScreen,
                  //         size: 15,
                  //         color: Colors.white,
                  //       ),
                  //     ).circular.ripple(() {
                  //       openFullScreen();
                  //     })),
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        height: 25,
                        width: 25,
                        color: Colors.black38,
                        child: ThemeIconWidget(
                          isMute ? ThemeIcon.micOff : ThemeIcon.mic,
                          size: 15,
                          color: Colors.white,
                        ),
                      ).circular.ripple(() {
                        if (isMute == true) {
                          unMuteAudio();
                        } else {
                          muteAudio();
                        }
                      })),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  prepareVideo({required String url, required bool isLocalFile}) {
    if (videoPlayerController != null) {
      videoPlayerController!.pause();
    }
    if (isLocalFile) {
      videoPlayerController = VideoPlayerController.file(File(url));
    } else {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    }

    initializeVideoPlayerFuture = videoPlayerController!.initialize().then((_) {
      setState(() {});
      play();
    });

    videoPlayerController!.addListener(checkVideoProgress);
  }

  openFullScreen() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return FullScreenVideoPostTile(
              videoPlayerController: videoPlayerController!);
        },
        fullscreenDialog: true));
  }

  unMuteAudio() {
    videoPlayerController!.setVolume(1);
    setState(() {
      isMute = false;
    });
  }

  muteAudio() {
    videoPlayerController!.setVolume(0);
    setState(() {
      isMute = true;
    });
  }

  play() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPlayed = false;
        playVideo = true;
      });
    });
    videoPlayerController!.play().then(
        (value) => {videoPlayerController!.addListener(checkVideoProgress)});

    if (isMute) {
      videoPlayerController!.setVolume(0);
    }
  }

  pause() {
    videoPlayerController!.pause();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPlayed = true;
      });
    });
  }

  clear() {
    videoPlayerController!.pause();
    videoPlayerController!.dispose();
    videoPlayerController!.removeListener(checkVideoProgress);
  }

  void checkVideoProgress() {
    if (videoPlayerController!.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {}

    if (videoPlayerController!.value.position ==
            videoPlayerController!.value.duration &&
        videoPlayerController!.value.duration >
            const Duration(milliseconds: 1)) {
      if (!mounted) return;

      setState(() {
        videoPlayerController!.removeListener(checkVideoProgress);

        isPlayed = true;
      });
    }
  }
}
