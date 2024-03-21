import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String _mPath = 'tau_file.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
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
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    // final session = await AudioSession.instance;
    // await session.configure(AudioSessionConfiguration(
    //   avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
    //   avAudioSessionCategoryOptions:
    //   AVAudioSessionCategoryOptions.allowBluetooth |
    //   AVAudioSessionCategoryOptions.defaultToSpeaker,
    //   avAudioSessionMode: AVAudioSessionMode.spokenAudio,
    //   avAudioSessionRouteSharingPolicy:
    //   AVAudioSessionRouteSharingPolicy.defaultPolicy,
    //   avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
    //   androidAudioAttributes: const AndroidAudioAttributes(
    //     contentType: AndroidAudioContentType.speech,
    //     flags: AndroidAudioFlags.none,
    //     usage: AndroidAudioUsage.voiceCommunication,
    //   ),
    //   androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    //   androidWillPauseWhenDucked: true,
    // ));

    _mRecorderIsInited = true;
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
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Center(
            child: Ink(
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
          ),
          Center(
            child:
              _mPlayer!.isPlaying
                  ? IconButton(
                onPressed: getPlaybackFn(),
                icon: const Icon(
                  Icons.stop_circle_rounded,
                  color: themeColour5,
                  size: 100,
                ),
              )
                  : IconButton(
                onPressed: getPlaybackFn(),
                icon: const Icon(
                  Icons.play_circle_fill_rounded,
                  color: themeColour5,
                  size: 100,
                ),
              ),
            ),
        ],
      );
    }

    // @override
    // Widget build(BuildContext context) {
    //   Widget makeBody() {
    //     return Column(
    //       children: [
    //         Container(
    //           margin: const EdgeInsets.all(3),
    //           padding: const EdgeInsets.all(3),
    //           height: 80,
    //           width: double.infinity,
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //             color: const Color(0xFFFAF0E6),
    //             border: Border.all(
    //               color: Colors.indigo,
    //               width: 3,
    //             ),
    //           ),
    //           child: Row(children: [
    //             ElevatedButton(
    //               onPressed: getRecorderFn(),
    //               //color: Colors.white,
    //               //disabledColor: Colors.grey,
    //               child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
    //             ),
    //             const SizedBox(
    //               width: 20,
    //             ),
    //             Text(_mRecorder!.isRecording
    //                 ? 'Recording in progress'
    //                 : 'Recorder is stopped'),
    //           ]),
    //         ),
    //         Container(
    //           margin: const EdgeInsets.all(3),
    //           padding: const EdgeInsets.all(3),
    //           height: 80,
    //           width: double.infinity,
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //             color: const Color(0xFFFAF0E6),
    //             border: Border.all(
    //               color: Colors.indigo,
    //               width: 3,
    //             ),
    //           ),
    //           child: Row(children: [
    //             ElevatedButton(
    //               onPressed: getPlaybackFn(),
    //               //color: Colors.white,
    //               //disabledColor: Colors.grey,
    //               child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
    //             ),
    //             const SizedBox(
    //               width: 20,
    //             ),
    //             Text(_mPlayer!.isPlaying
    //                 ? 'Playback in progress'
    //                 : 'Player is stopped'),
    //           ]),
    //         ),
    //       ],
    //     );
    //   }

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
