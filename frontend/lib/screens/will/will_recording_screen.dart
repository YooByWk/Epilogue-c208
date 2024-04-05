import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:frontend/screens/will/will_viewer_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/view_models/block_chain/block_chain_will_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/recording_viewmodel.dart';
import 'package:frontend/widgets/popup_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

typedef _Fn = void Function();

class WillRecordingScreen extends StatefulWidget {
  const WillRecordingScreen({super.key});

  @override
  _WillRecordingScreenState createState() => _WillRecordingScreenState();
}

class _WillRecordingScreenState extends State<WillRecordingScreen> {

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

  // 저장된 파일 불러오기
  Future<File> getRecordedFile() async {
    Directory cacheDir = await getTemporaryDirectory();
    String filePath = '${cacheDir.path}/will.mp4';
    File recordedFile = File(filePath);
    return recordedFile;
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

  File? audioFile;

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) async {
      setState(() {
        _mplaybackReady = true;
      });

      audioFile = await getRecordedFile();

      _stopwatch.reset();
      _stopwatch.stop();
      _timer?.cancel();
      setState(() {
        _recordTime = '00:00';
      });
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
    final willViewmodel = BlockChainWillViewModel();
    willViewmodel.init();
    return ChangeNotifierProvider(
        create: (context) => RecordingViewModel(),
        child:
            Consumer<RecordingViewModel>(builder: (context, viewModel, child) {
          Widget makeBody() {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: "녹음",
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                              ),
                              TextWidget(
                                text: "하기",
                                fontSize: 50,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          _mRecorder!.isRecording
                              ? Ink(
                                  width: 100,
                                  height: 100,
                                  decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Colors.grey,
                                  ),
                                  child: IconButton(
                                    onPressed: getRecorderFn(),
                                    icon: const Icon(
                                      Icons.keyboard_voice_outlined,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ))
                              : Ink(
                                  width: 100,
                                  height: 100,
                                  decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: themeColour3,
                                  ),
                                  child: IconButton(
                                    onPressed: getRecorderFn(),
                                    icon: const Icon(
                                      Icons.keyboard_voice,
                                      color: themeColour5,
                                      size: 50,
                                    ),
                                  ),
                                ),
                          Text(
                            _recordTime,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100.0),
                            child: Text(
                              '※ 작성된 테스트는 녹음의 편의성을 위한 것으로,\n   법적 효력은 없음을 알려드립니다.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20.0),
                            child: TextField(
                              maxLines: null,
                              minLines: 5,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 20.0),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(1.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                  // 포커스됐을 때 외곽선 설정
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      color: themeColour5,
                                      width: 2.0), // 여기서 색깔 변경
                                ),
                              ),
                            ),
                          ),
                          _mPlayer!.isPlaying
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
                                        _mPlayer!.seekToPlayer(Duration(
                                            milliseconds: value.toInt()));
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_formatDuration(Duration(
                                            milliseconds:
                                                _currentPosition.toInt()))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Text(_formatDuration(Duration(
                                              milliseconds:
                                                  _currentDuration.toInt()))),
                                        ),
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
                                        _mPlayer!.seekToPlayer(Duration(
                                            milliseconds: value.toInt()));
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_formatDuration(Duration(
                                            milliseconds:
                                                _currentPosition.toInt()))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Text(_formatDuration(Duration(
                                              milliseconds:
                                                  _currentDuration.toInt()))),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ]),
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => PopupWidget(
                            text: '기록된 유언은 \n블록 체인에 기록됩니다.\n정말 생성하시겠습니까?',
                            buttonText1: '돌아가기',
                            onConfirm1: () {
                              Navigator.pop(context);
                            },
                            buttonText2: '생성하기',
                            onConfirm2: () async {
                              // 여기임
                              
                              viewModel.setFile(audioFile!);
                              viewModel.setRecording().then((_) {
                                if (viewModel.errorMessage == null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WillViewerScreen(),
                                    ),
                                  );

                              debugPrint('블록체인 호출');
                               willViewmodel.createWill();
                                } else {
                                  if (viewModel.errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(viewModel.errorMessage!),
                                      ),
                                    );
                                  }
                                }
                              });
                            },
                          ));
                },
              ),
            ),
          );
        }));
  }
}
