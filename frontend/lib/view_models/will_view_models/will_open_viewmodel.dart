import 'package:flutter/material.dart';
import 'package:frontend/services/will_service.dart';
import 'package:video_player/video_player.dart';

class WillOpenViewModel extends ChangeNotifier {
  final WillService _willService = WillService();
  VideoPlayerController? videoPlayerController;

  String? _s3url;
  String? get s3url => _s3url;


  Future<void> submitCode(String willCode) async {
    // debugPrint(willCode);
    final result = await _willService.willOpen(willCode);
    if (!result['success']) {
      int statusCode = result['statusCode'];
    } else {
      _s3url = result['willFileAddress'];
      debugPrint(_s3url);
    }
  }
}
