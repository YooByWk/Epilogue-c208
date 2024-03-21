import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_widgets.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_videotab_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:frontend/main.dart';

class VideoTab extends StatelessWidget {
  const VideoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => VideoTabViewModel(),
        child:
            Consumer<VideoTabViewModel>(builder: (context, viewModel, child) {
          return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 50) {
                  viewModel.loadMore();
                }
                return false;
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: (ListView.builder(
                  itemCount: viewModel.videos.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // return Text('비디오 탭입니다.');
                      return Padding( padding:EdgeInsets.fromLTRB(8, 0, 8, 0), child:Column(children: [
                        SizedBox(height: 10),
                        MemorialVideoUploadButton(
                            width: MediaQuery.of(context).size.width,
                            onPressed: () {
                              debugPrint('비디오 업로드 버튼 클릭');
                              Navigator.pushNamed(context,'/blockChain');
                              ;
                            }),
                        SizedBox(height: 10)
                      ]));
                    }
                    if (index >= viewModel.videos.length) {
                      return null; // 수정: index가 viewModel.videos.length 이상일 때는 null을 반환합니다.
                    }
                    return VideoCard(
                      key: ValueKey(index),
                      videoPath: viewModel.videos[index],
                      index: index,
                    );
                  },
                )),
              ));
        }));
  }
}

//////////////////////////////////////////////////////////
class VideoCard extends StatefulWidget {
  final String videoPath;
  final int index;

  VideoCard({
    Key? key,
    required this.videoPath,
    required this.index,
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
    videoPlayerController = VideoPlayerController.asset(widget.videoPath);
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
      placeholder: Container(
        // color: Colors.white,
        child: FutureBuilder<Uint8List?>(
          future: generateThumbnail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return Image.memory(snapshot.data!);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
    ;
    generateThumbnail();
  }

  Future<Uint8List?> generateThumbnail() async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: widget.videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
    return thumbnail;
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
          debugPrint(
              '비디오 ${widget.index} 가 ${visibilityInfo.visibleFraction * 100} % 보여짐');
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
                        ListTile(
                          title: Text('비디오 ${widget.index}'),
                          trailing: Text(DateTime.now().toString()),
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Chewie(
                            controller: chewieController,
                          ),
                        ),
                        SizedBox(height: 35)
                      ],
                    )))));
  }
}
