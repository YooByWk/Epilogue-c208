import "package:web3dart/web3dart.dart";
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class BlockChainWalletModel {

  late String _walletAddress;
  late EthPrivateKey _privateKey;
  final storage = FlutterSecureStorage();
  bool hasWallet = false;


  String get walletAddress => _walletAddress;

  Future<void> createWallet() async {
    var rng = Random.secure();
    var credentials = EthPrivateKey.createRandom(rng);
    var address = await credentials.address;

    _walletAddress = address.hex;
    _privateKey = credentials;

    await storage.write(key: "privateKey", value: _privateKey.toString());
    var writenKey = (await storage.read(key: 'privateKey'));
    debugPrint(writenKey.toString());
  }

  Future<void> checkWallet(String address) async{
      String? privateKey = await storage.read(key: "privateKey");

      if (privateKey != null) {
        _privateKey = EthPrivateKey.fromHex(privateKey);
        hasWallet = true;
      } else {
        hasWallet = false;
        debugPrint('Todo : No wallet found, please create a wallet first.');
      }
  }

  // 1. 지갑 주소로 트랜잭션을 찾을 수 있는가
  // 2. 뭐지?
} 

