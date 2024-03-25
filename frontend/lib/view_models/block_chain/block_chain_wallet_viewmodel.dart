import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:convert/convert.dart';  // hex
import 'dart:typed_data';

class BlockChainWalletViewModel extends ChangeNotifier {

  final BlockChainWalletModel _model;
  final storage = FlutterSecureStorage();
  final _mnemonicControllers = List.generate(12, (index) => TextEditingController());
  List<TextEditingController> get mnemonicControllers => _mnemonicControllers;

  BlockChainWalletViewModel (this._model);

  Future<void> createWallet() async{
    debugPrint('createWallet() called ');

    if (_model.hasWallet) {
      debugPrint('Todo : Wallet already exists. 디버그를 위해 중복 생성이 가능한 상태임.');

      // return;
    }

    // 니모닉 구문 생성
    String mnemonic = bip39.generateMnemonic();
    // debugPrint('mnemonic $mnemonic');

    // 니모닉 구문을 통한 시드 생성
    Uint8List seed = bip39.mnemonicToSeed(mnemonic);
    bip32.BIP32 root = bip32.BIP32.fromSeed(seed);
    // 시드를 사용, 개인 키 생성
    bip32.BIP32 child = root.derivePath("m/44'/60'/0'/0/0");
    var privateKeyHex = child.privateKey!.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    var privateKey = EthPrivateKey.fromHex(privateKeyHex);  
    debugPrint('개인키 : $privateKeyHex');
    debugPrint(' 개인키 정수 : ${privateKey.privateKeyInt}');
    debugPrint('실험 주소 : ${privateKey.address}');

    _model.setWallet(privateKeyHex, privateKey.address.toString());
    debugPrint(' 꾸엑 키 ${_model.privateKey}');
    debugPrint(' 꾸엑 주소 ${_model.walletAddress}');



    await storage.write( key: "credentials", value: _model.privateKey); // 키 저장
    await storage.write( key: "walletAddress", value: _model.walletAddress); // 키 저장
    await storage.write( key : 'mnemonic', value: mnemonic); // 니모닉 저장
    var writenKey = (await storage.read(key: 'privateKey')); // 저장된 키 값 확인
    var writenAddress = (await storage.read(key : 'walletAddress'));
    var wrtienMnemonic = (await storage.read(key : 'mnemonic'));
    debugPrint('저장된 개인키 : $writenKey, 저장된 주소 : $writenAddress');
    debugPrint('저장된 니모닉 : $wrtienMnemonic');
    // 니모닉을 통한 만들기 다시
    Uint8List seed2 = bip39.mnemonicToSeed(wrtienMnemonic!);
    bip32.BIP32 root2 = bip32.BIP32.fromSeed(seed2);
    bip32.BIP32 child2 = root2.derivePath("m/44'/60'/0'/0/0");
    var privateKeyHex2 = child2.privateKey!.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    var privateKey2 = EthPrivateKey.fromHex(privateKeyHex2);
    
    debugPrint('복구된 개인키 : $privateKeyHex2');
    debugPrint('복구된 주소 : ${privateKey2.address}');
    debugPrint(privateKey == privateKey2 ? '복구 성공' : '복구 실패');
  }



// 니모닉을 통한 지갑 복구

int validateMnemonic() {
  for (int i = 0; i < _mnemonicControllers.length; i++) {
    if (_mnemonicControllers[i].text.isEmpty) {
      debugPrint('모든 단어를 입력해주세요.');
      return 0;
    }
  }

  String mnemonic = _mnemonicControllers.map((e) => e.text).join(' ');
  if (!bip39.validateMnemonic(mnemonic)) {
    debugPrint('니모닉이 유효하지 않습니다.');
    return 1;
  }

  return -1;
}

  Future<void> recoverFromMnemonic() async {
    if (validateMnemonic() != -1) {
      debugPrint(validateMnemonic().toString());
      switch (validateMnemonic()) {
        case 0:
          debugPrint('모든 단어를 입력해주세요.');
          break;
        case 1:
          debugPrint('니모닉이 유효하지 않습니다.');
          break;
      }


      return;
    }
     
    String mnemonic = _mnemonicControllers.map((e) => e.text).join(' ');
    
    Uint8List seed = bip39.mnemonicToSeed(mnemonic);
    bip32.BIP32 root = bip32.BIP32.fromSeed(seed);
    // 시드를 사용, 개인 키 생성
    bip32.BIP32 child = root.derivePath("m/44'/60'/0'/0/0");
    var privateKeyHex = child.privateKey!.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    var privateKey = EthPrivateKey.fromHex(privateKeyHex);  
    debugPrint('개인키 : $privateKeyHex');
    debugPrint(' 개인키 정수 : ${privateKey.privateKeyInt}');
    debugPrint('실험 주소 : ${privateKey.address}');

    _model.setWallet(privateKeyHex, privateKey.address.toString());
    debugPrint(' 꾸엑 키 ${_model.privateKey}');
    debugPrint(' 꾸엑 주소 ${_model.walletAddress}');



    await storage.write( key: "credentials", value: _model.privateKey); // 키 저장
    await storage.write( key: "walletAddress", value: _model.walletAddress); // 키 저장
    await storage.write( key : 'mnemonic', value: mnemonic); // 니모닉 저장
    var writenKey = (await storage.read(key: 'privateKey')); // 저장된 키 값 확인
    var writenAddress = (await storage.read(key : 'walletAddress'));
    var wrtienMnemonic = (await storage.read(key : 'mnemonic'));
    debugPrint('저장된 개인키 : $writenKey, 저장된 주소 : $writenAddress');
    debugPrint('저장된 니모닉 : $wrtienMnemonic');
  } 

  // Future<void> checkWallet() async {
  //   debugPrint('checkWallet() called ');

  //   String? privateKey  = await storage.read(key : 'privateKey');
  //   debugPrint('이하 개인키 : $privateKey');
    
  //   if (privateKey != null) {
  //     EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey); 
  //     debugPrint('credentials : ${credentials.privateKey}');
  //     EthereumAddress derivedAddress =  credentials.address;

  //     _model.setWallet(credentials, derivedAddress.hex);
  //     debugPrint('Wallet found and set to model : $derivedAddress.hex');
  //   }
  //   // } else {
  //     // _model.hasWallet = false;
  //     // debugPrint('Todo : No wallet found, please create a wallet first.');
  //   // }

  // }
  // Future<void> readPrivateKey() async {
  //   String? privateKey = await storage.read(key:'privateKey');
  //   debugPrint('readPrivateKey() called : $privateKey.toString()');
  // }

}


/*
  //
  Future<void> createWallet() async {
    debugPrint('createWallet() called ');

    if (hasWallet) {
      debugPrint('Todo : Wallet already exists.');
      return;
    }

    // 니모닉 구문 생성
    String mnemonic = bip39.generateMnemonic();
    debugPrint('mnemonic $mnemonic');

    // 니모닉 구문을 통한 시드 생성
    var seed = bip39.mnemonicToSeed(mnemonic);
    // 시드를 사용, 개인 키 생성
    var credentials = EthPrivateKey.fromHex(seed.toString());
    var address = await credentials.address; // 지갑 주소 생성
    debugPrint('address : $address');

    // var rng = Random.secure(); // 랜덤 생성
    // var credentials = EthPrivateKey.createRandom(rng); // 개인키 생성
    // var address = await credentials.address; // 지갑 주소 생성

    _walletAddress = address.hex;
    _privateKey = credentials; // 지갑 주소와 개인키 생성

    await storage.write(
        key: "privateKey", value: _privateKey.toString()); // 키 저장
    var writenKey = (await storage.read(key: 'privateKey')); // 저장된 키 값 확인
    debugPrint(writenKey.toString());
  }


  Future<void> checkWallet(String address) async {
    debugPrint('checkWallet() called ');
    String? privateKey = await storage.read(key: "privateKey");

    if (privateKey != null) {
      _privateKey = EthPrivateKey.fromHex(privateKey);
      hasWallet = true;
    } else {
      hasWallet = false;
      debugPrint('Todo : No wallet found, please create a wallet first.');
    }
  }

*/