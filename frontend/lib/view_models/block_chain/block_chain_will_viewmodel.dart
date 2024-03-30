import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';
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
 createAudioHash() async {
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
  debugPrint('Hash: ${hash.toString()}');

  setAudioHash(AudioHash(
      filePath: filePath,
      fileName: filePath.split('/').last,
      date: DateTime.now(),
      hash: hash.toString())); // Convert hash to uppercase
  return hash.toString();
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


class BlockChainWillViewModel extends ChangeNotifier {
  final BlockChainWillModel _model = BlockChainWillModel();
  final storage = FlutterSecureStorage();
  final UserViewModel _userViewModel = UserViewModel();
  late String? userId;


  BlockChainWillViewModel() {
    init();
    // userId =  _userViewModel.fetchUserId();
  }

  Future<void> init() async {
    // print(storage.read(key: 'userId'));
    // userId =  _userViewModel.fetchUserId();
    // userId = await storage.read(key: 'userId');
    await _model.init();
    // print('모델 id : $_model.userId');
    userId = await storage.read(key: 'userId');

  }

  // Future<String> get pk => _model.pk;
  // Future<String> get address => _model.address;
  // Future<String> get ABI => _model.ABI;
  
  Future sendTransaction(String functionName, List<dynamic> params) async {
    // await init();
    // print('createWill() called');
    // print()
    // print(await userId);
    // print(await pk);
    // print(await address);
    // print(await ABI);
    // print('ㅁㄴㅇㄹ ${await userId}');
    // final res = await _model.sendTransaction(functionName, params);
    // return print(userId);
    // debugPrint(res);

  }
  
  Future createWill() async {
    // 함수 이름
    // 넣을 값
    init();
    String fileHash = await AudioHashViewModel().createAudioHash();
    var id = await storage.read(key: 'userId');
    final params = await [id, fileHash];
    final res = await _model.sendTransaction('유언장이 등록되었습니다.','createWill', params);
    debugPrint(res);


    return res;
  }

  
  Future MyWill () async {
    await init();
    var test = await _model.address;
    EthereumAddress address = EthereumAddress.fromHex(test);
    // print(test);
    final res = await _model.callFunction('addressToWill', [address]);
    return res.toString();
  }
  // Future

  Future deleteWill () async {
    await init();
    final res = await _model.sendTransaction('유언장이 삭제되었습니다.','DeleteWill', [userId]);
    return res;
  }

  Future SearchByHash () async {
    await init();
    // 다운로드 된 파일 해시를 불러온다.
    var hashvalue = await AudioHashViewModel().createAudioHash();
    // 해당 해시와 유저 아이디를 담아서 params로 만든다.
    final params = await [ hashvalue, userId];
    // 해당 params를 통해 함수를 실행한다.
    final res = await _model.callFunction('SearchByHash', params);
    // 결과를 반환한다.
    return res.toString();
  }

  Future WillCheck () async {
    // 1. 다운받는다 - 임시 경로
    
    // 2. 다운받은 파일의 해시를 구한다.

    // 3. 해당 해시를 블록체인 이용해 SearchByHash를 실행한다.

    // 뭔가 되겠지?
  }
}
