import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/block_chain_will_model.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
class AudioHashViewModel extends ChangeNotifier {
  AudioHash? _audioHash;

  AudioHash? get audioHash => _audioHash;

  void setAudioHash(AudioHash audioHash) {
    _audioHash = audioHash;
    notifyListeners();
  }

  // /data/user/0/com.example.frontend/cache/will.mp4
Future<void> createAudioHash() async {
  var filePath = '/data/user/0/com.example.frontend/cache/will.mp4';
  // var filePath = '/data/user/0/com.example.frontend/cache/will.mp4';
  var file = File(filePath);
  debugPrint('File path: $filePath');

  if (!file.existsSync()) {
    throw Exception('File does not exist: $filePath');
  }

  final bytes = await file.readAsBytes();

  // Generate SHA256 hash similar to PowerShell's Get-FileHash
  final hash = sha256.convert(bytes);
  debugPrint('Hash: ${hash.toString().toUpperCase()}');

  setAudioHash(AudioHash(
      filePath: filePath,
      fileName: filePath.split('/').last,
      date: DateTime.now(),
      hash: hash.toString().toUpperCase())); // Convert hash to uppercase
}

Future<void> checkHash() async {
  FilePickerResult? downloadResult = await FilePicker.platform.pickFiles();

  if (downloadResult != null) {
    PlatformFile downloadFile = downloadResult.files.first;
    // var cacheFile = File('/data/data/com.example.frontend/cache/NewTextFile.txt');
  // var cacheFile = File('/data/user/0/com.example.frontend/cache/will.mp4');
  var cacheFile = File('/data/user/0/com.example.frontend/cache/file_picker/1711372160436/will.mp4');

    final downloadFileObject = File(downloadFile.path!);
    final downloadBytes = await downloadFileObject.readAsBytes();
    final cacheBytes = await cacheFile.readAsBytes();

    if (downloadBytes != null) {
      final downloadHash = sha256.convert(downloadBytes);
      final cacheHash = sha256.convert(cacheBytes);

      debugPrint("Check hash: ${downloadHash.toString() == cacheHash.toString() ? 'Match' : 'No match'}");
      debugPrint('Download hash: ${downloadHash.toString().toUpperCase()}');
      debugPrint('Cached hash: ${cacheHash.toString().toUpperCase()}');
    } else {
      debugPrint('Download file bytes is null');
    }
  } else {
    debugPrint('User canceled the picker');
  }
}
}
