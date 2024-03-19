import 'package:flutter/material.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_videotab_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoTab extends StatelessWidget {
  const VideoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoTabViewModel(),
      child: Consumer<VideoTabViewModel>(builder: (context, viewModel, child) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 50) {
              viewModel.loadMore();
            }
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index ==0) {
                      return VideoCard(
                        key: ValueKey(index),
                        videoPath: viewModel.videos[index],
                        index : index,

                      );
                    }
                  }
                ),
              )
            ]
          ),
        );
      })
    );
  }
}

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

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;


 @override
 void initState() {
  super.initState();
  videoPlayerController = VideoPlayerController.asset(widget.videoPath);
  chewieController = ChewieController(
    videoPlayerController : videoPlayerController,
    autoPlay : true,
    looping : false,
    
  );
 }
  @override
  void dispose () {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Chewie(
        controller : chewieController,
      ),
    );
  }

}