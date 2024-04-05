import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart'; // 플러터 사운드를 사용하기 위해 import
import 'dart:async'; // Timer 클래스를 사용하기 위해 import
import 'dart:convert'; // json 인코딩을 위해 import
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:path_provider/path_provider.dart'; // material 디자인을 사용하기 위해 import

typedef _Fn = void Function();

class MyPagePlay extends StatefulWidget {
  final String path;
  MyPagePlay(
      {
      required this.path,
      Key? key})
      : super(key: key);

  @override
  _MyPagePlayState createState() => _MyPagePlayState();
}

class _MyPagePlayState extends State<MyPagePlay> {
  Codec _codec = Codec.aacMP4;
  StreamController<PlaybackDisposition> _progressController = StreamController<PlaybackDisposition>.broadcast();

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  bool _mPlayerIsPlaying = false;
  bool _mplaybackReady = false;

  // late String _filePath;
  // 플레이 여부
  bool _isPlaying = false;
  bool _mPlayerIsPaused = false ; 
  // 플레이 시간
  double _playTime = 0.0;
  double _currentPlayTime = 0.0;
  Timer? _timer;

  // 플레이 시간을 표시할 텍스트 00분 00초
  String _formatDuration(Duration duration) {
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

@override
void initState() {
  super.initState();
  _mPlayer!.openPlayer().then((value) {
    setState(() {
      _mPlayerIsInited = true;
      _mPlayer!.setSubscriptionDuration(
          Duration(milliseconds: 100)); // 0.1초마다 업데이트
      _mPlayer!.onProgress!.listen((e) {
        // 플레이 시간 업데이트
        if (e != null) {
          setState(() {
            _currentPlayTime =
                e.position.inMilliseconds.toDouble(); // 현재 플레이 시간
          });
          _progressController.add(e); // onProgress 스트림 업데이트
        }
      });
    });
  });
}

  @override // 오디오 플레이어 종료
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null; // 오디오 플레이어 해제
    super.dispose(); // 상위 클래스의 dispose 호출
  }

  Future<File> getAudioFIle() async {
    // 오디오 파일을 다운로드 받아서 파일로 반환
    Directory cacheDir = await getTemporaryDirectory(); // 캐시 디렉토리
    String path = '${cacheDir.path}/downloadedwill.mp4'; // 다운로드 받을 파일 경로
    // _filePath = path; // 파일 경로 저장
    return File(path); // 파일 반환
  }

  String _formatTime(int milliseconds) {
    // 시간 포멧팅
    int seconds = (milliseconds / 1000).truncate(); // 초
    int minutes = (seconds / 60).truncate(); // 분
    
    
    String secondsStr = (seconds % 60).toString().padLeft(2, '0'); // 초 포멧팅
    String minutesStr = (minutes % 60).toString().padLeft(2, '0'); // 분 포멧팅

    return '$minutesStr:$secondsStr'; // 분:초 반환
  }

void _play() async {
  if (!_mPlayerIsInited) return;
  File audioFile = await getAudioFIle();
  await _mPlayer!.startPlayer(fromURI: widget.path).then((duration) {
    setState(() {
      _playTime = duration!.inMilliseconds.toDouble();
      _mPlayerIsPlaying = true;
    });
  });
}

void _pause() async {
  if (!_mPlayerIsInited || !_mPlayerIsPlaying) return;
  await _mPlayer!.pausePlayer();
  setState(() {
    _mPlayerIsPlaying = false;
    _mPlayerIsPaused = true; // 일시 중지 상태로 업데이트
  });
}

void _resume() async {
  if (!_mPlayerIsInited || _mPlayerIsPlaying) return;
  await _mPlayer!.resumePlayer();
  setState(() {
    _mPlayerIsPlaying = true;
    _mPlayerIsPaused = false; // 재생 상태로 업데이트
  });
}

void _stop() async {
  if (!_mPlayerIsInited) return;
  await _mPlayer!.stopPlayer();
  setState(() {
    _mPlayerIsPlaying = false;
    _currentPlayTime = 0.0;
    _mPlayerIsPaused = false;
  });
  _progressController.add(PlaybackDisposition(position: Duration.zero)); // onProgress 스트림을 0으로 설정
}

  void pauseResumePlayer() async {
    if (_mPlayerIsPlaying) {
      await _mPlayer!.pausePlayer();
    } else {
      await _mPlayer!.resumePlayer();
    }
    setState(() {
      _mPlayerIsPlaying = !_mPlayerIsPlaying;
    });
  }

  // UI

_Fn? getPauseResumeFn() {
  if (_mPlayerIsPlaying) {
    return _pause;
  } else if (_mPlayerIsPaused) {
    return _resume; // 일시 중지 상태일 때는 _resume 함수를 반환
  } else {
    return _play;
  }
}

  _Fn? getPlaybackFn() {
    if (_mplaybackReady) {
      return _play;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('path at the end: ${widget.path}');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_mPlayerIsPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: getPauseResumeFn(),
              ),
              StreamBuilder<PlaybackDisposition>(
  stream: _progressController.stream, // 수정된 스트림 사용
  builder: (context, snapshot) {
    final PlaybackDisposition? progress = snapshot.data;
    final double duration = _playTime;
    return Column(
      children: [

        Slider(
          thumbColor: themeColour5,
          activeColor: themeColour3,
          value: progress != null
              ? progress.position.inMilliseconds.toDouble()
              : 0.0,
          onChanged: (value) {
            _mPlayer!
                .seekToPlayer(Duration(milliseconds: value.toInt()));
          },
          min: 0.0,
          max: duration,
        ),
if (progress != null)
  Center(
    child: Text(
      '${_formatTime(progress.position.inMilliseconds)} / ${_formatTime(duration.toInt())}',
      style: TextStyle(fontSize: 12),
    ),
  ),
      ],
    );
  },
),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: _stop,
              ),
            ],
          ),
        ],
      ),
    );
  }
}