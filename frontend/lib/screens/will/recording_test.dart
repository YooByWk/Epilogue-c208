import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:frontend/screens/will/will_viewer_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

typedef _Fn = void Function();

class RecordTest extends StatefulWidget {
  const RecordTest({super.key});

  @override
  _RecordTestState createState() => _RecordTestState();
}

class _RecordTestState extends State<RecordTest> {
  Codec _codec = Codec.aacMP4;
  String _mPath = 'will.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  // record time 실시간
  Stopwatch _stopwatch = Stopwatch();
  String _recordTime = '00:00';
  Timer? _timer;

  // 첫 번째 play 하는 건지, 일시정지 및 다시 재생 하는 건지 판단
  bool _isPlaying = false;

  // 전체 재생 시간과 현재 재생 위치
  double _currentPosition = 0;
  double _currentDuration = 0;

  // 00:00의 형식으로 맞추기 위한 함수
  String _formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
        _mPlayer!.setSubscriptionDuration(Duration(milliseconds: 100));
        _mRecorder!.setSubscriptionDuration(Duration(milliseconds: 100));
        _mPlayer!.onProgress!.listen((e) {
          setState(() {
            _currentPosition = e.position.inMilliseconds.toDouble();
            _currentDuration = e.duration.inMilliseconds.toDouble();
          });
        });
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });

    _mRecorder!.setSubscriptionDuration(Duration(milliseconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'will.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    _mRecorderIsInited = true;
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      // audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        _recordTime = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    });
  }


  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {
      _recordTime = '00:00';
    });
  }

  void play() {
    assert(_mPlayerIsInited && _mplaybackReady && _mRecorder!.isStopped);
    _mPlayer!
        .startPlayer(
      fromURI: _mPath,
      whenFinished: () {
        setState(() {
          _currentPosition = 0;
        });
      },
    )
        .then((value) {
      setState(() {
        _isPlaying = true;
      });
    });
  }

  void pauseResumePlayer() async {
    try {
      if (_mPlayer!.isPlaying) {
        await _mPlayer!.pausePlayer();
        setState(() {
          _isPlaying = true;
        });
      } else {
        await _mPlayer!.resumePlayer();
        setState(() {
          _isPlaying = true;
          debugPrint('$_isPlaying');
        });
      }
    } on Exception catch (err) {
      _mPlayer!.logger.e('error: $err');
    }
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPauseResumeFn() {
    if (_mPlayer!.isPaused || _mPlayer!.isPlaying) {
      return pauseResumePlayer;
    }
    return null;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }

    if (_isPlaying && _currentPosition == 0) {
      return play;
    }
    if (_isPlaying) {
      return pauseResumePlayer;
    } else {
      return play;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Center(
            child: Column(
              children: [
                Ink(
                  width: 100,
                  height: 100,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: themeColour3,
                  ),
                  child: _mRecorder!.isRecording
                      ? IconButton(
                          onPressed: getRecorderFn(),
                          icon: const Icon(
                            Icons.keyboard_voice_outlined,
                            color: themeColour5,
                            size: 50,
                          ),
                        )
                      : IconButton(
                          onPressed: getRecorderFn(),
                          icon: const Icon(
                            Icons.keyboard_voice,
                            color: themeColour5,
                            size: 50,
                          ),
                        ),
                ),
                Text(_recordTime),
              ],
            ),
          ),
          Center(
            child: _mPlayer!.isPlaying
                ? Column(
                    children: [
                      IconButton(
                        onPressed: getPauseResumeFn(),
                        icon: const Icon(
                          Icons.pause_circle_filled_rounded,
                          color: themeColour5,
                          size: 100,
                        ),
                      ),
                      Slider(
                        value: _currentPosition,
                        min: 0,
                        max: _currentDuration,
                        onChanged: (value) {
                          // 재생 위치 조정
                          _mPlayer!.seekToPlayer(
                              Duration(milliseconds: value.toInt()));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(Duration(
                              milliseconds: _currentPosition.toInt()))),
                          Text(_formatDuration(Duration(
                              milliseconds: _currentDuration.toInt()))),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      IconButton(
                        onPressed: getPlaybackFn(),
                        icon: const Icon(
                          Icons.play_circle_fill_rounded,
                          color: themeColour5,
                          size: 100,
                        ),
                      ),
                      Slider(
                        value: _currentPosition,
                        min: 0,
                        max: _currentDuration,
                        onChanged: (value) {
                          // 재생 위치 조정
                          _mPlayer!.seekToPlayer(
                              Duration(milliseconds: value.toInt()));
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(Duration(
                              milliseconds: _currentPosition.toInt()))),
                          Text(_formatDuration(Duration(
                              milliseconds: _currentDuration.toInt()))),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: const Text('유언장 생성하기'),
      ),
      body: makeBody(),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100,
        child: TextButtonWidget(
          preText: '이전',
          nextText: '기록하기',
          nextPage: WillViewerScreen(),
        ),
      ),
    );
  }
}
