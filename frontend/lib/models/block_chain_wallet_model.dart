import "package:web3dart/web3dart.dart";
import 'packagae:http/http.dart' as http; 
import 'package:flutter/material.dart';

class BlockChainWalletModel {
  String _walletAddress;
  EthPrivateKey _privateKey;

  String get walletAddress => _walletAddress;

  Future<void> createWallet() async {
    var rng = new Random.secure();
    var credentials = EthPrivateKey.createRandom(rng);
    var address = await credentials.address;

  _walletAddress = address.hex;
  _privateKey = credentials;
  }
}

