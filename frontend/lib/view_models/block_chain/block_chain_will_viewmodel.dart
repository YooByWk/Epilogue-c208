import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/block_chain_will_model.dart';

class AudioHashViewModel extends ChangeNotifier {
  AudioHash? _audioHash;

  AudioHash? get audioHash => _audioHash;

  void setAudioHash(AudioHash audioHash) {
    _audioHash = audioHash;
    notifyListeners();
  }
 // /data/user/0/com.example.frontend/cache/will.mp4
  Future<void> createAudioHash(String filePath) async {
    final bytes = await File('/data/user/0/com.example.frontend/cache/will.mp4').readAsBytes();
    final hash = sha256.convert(bytes);
    setAudioHash(AudioHash(
        filePath: filePath,
        fileName: filePath.split('/').last,
        date: DateTime.now(),
        hash: hash.toString()));
      debugPrint(hash.toString());  
  }
}
