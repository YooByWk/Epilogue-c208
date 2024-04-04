import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/main.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_video_detail_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

final _storage = FlutterSecureStorage();
bool isLogin = false;
class MemorialVideoDetailScreen extends StatelessWidget {
  const MemorialVideoDetailScreen({Key? key});

  Future<String?> getToken() async {
    String? token = await _storage.read(key: 'token');
    isLogin = token != null;
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemorialVideoDetailViewModel(),
      child: Consumer<MemorialVideoDetailViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: themeColour2,
                title: const Text('세월은 가도 영상은 남는다.'),
              ),
              body: viewModel.isLoading
                  ? Center(
                      child: CircularProgressIndicator(), // 로딩 중 표시
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('게시물 신고하기'),
                                    content: Text('게시물을 신고하시겠습니까?', style: TextStyle(fontSize: 20),),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('취소'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          viewModel.reportVideo();
                                          Navigator.of(context).pop();
                                          if (viewModel.errorMessage != null) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    content:
                                                    Text(viewModel.errorMessage!)));
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    content:
                                                    Text('게시물 신고가 완료되었습니다')));
                                          }
                                        },
                                        child:  Text('신고하기', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(Icons.warning, color: Colors.red),
                                ),
                                SizedBox(width: 10,),
                                Text('게시물 신고하기', style: TextStyle(fontSize: 20, color: Colors.red),),
                              ],
                            ),
                          ),
                          VideoCard(
                            videoPath:
                                viewModel.memorialVideoDetailModel!.s3url,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
                            child: Text(viewModel.memorialVideoDetailModel?.content ?? '', style: TextStyle(fontSize: 24),),
                          ),
                        ],
                      ),
                    ));
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////////
class VideoCard extends StatefulWidget {
  final String videoPath;

  VideoCard({
    Key? key,
    required this.videoPath,
  }) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

//////////////////////////////////////////////////////////
class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  late ScrollController scrollController;
  Uint8List? thumbnailPath;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
    scrollController = ScrollController();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      autoInitialize: true,
      allowMuting: false,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: false,
      showControlsOnInitialize: false,
      showControls: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key('visible-$widget.index'),
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage == 100) {
            // 화면 중앙에 가장 가까운 비디오를 재생합니다.
            if (!videoPlayerController.value.isPlaying) {
              debugPrint('비디오 재생');
              videoPlayerController.play();
            }
          } else {
            // 비디오를 일시정지합니다.
            videoPlayerController.pause();
          }
          videoPlayerController.addListener(() {
            debugPrint(
                'Video is playing: ${videoPlayerController.value.isPlaying}');
          });
        },
        child: GestureDetector(
            onLongPressStart: (details) {
              if (videoPlayerController.value.isPlaying) {
                videoPlayerController.pause();
              }
            },
            onLongPressEnd: (details) {
              if (!videoPlayerController.value.isPlaying) {
                videoPlayerController.play();
              }
            },
            onTap: () {
              if (!videoPlayerController.value.isPlaying) {
                videoPlayerController.play();
              } else {
                videoPlayerController.pause();
              }
            },
            child: Card(
                child: Container(
                    color: themeColour1,
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Chewie(
                            controller: chewieController,
                          ),
                        ),
                        // SizedBox(height: 35)
                      ],
                    )))));
  }
}
