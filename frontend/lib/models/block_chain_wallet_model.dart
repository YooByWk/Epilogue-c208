import "package:web3dart/web3dart.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BlockChainWalletModel {
  late String _walletAddress; // 지갑 주소
  // late EthPrivateKey _privateKey;
  late String _privateKey;
  List<String> mnemonicList = [];

  void setMnemonicList(List<String> mnemonicList) {
    this.mnemonicList = mnemonicList;
  }

  // late String _key;
  final storage = FlutterSecureStorage();
  bool hasWallet = false;

  String get walletAddress => _walletAddress;
  String get privateKey => _privateKey.toString();
  // String get key => _key;

  void setWallet (String privateKey, String walletrAddress) {
    _privateKey = privateKey;
    _walletAddress = walletrAddress;
    // _key = key;
    hasWallet = true; 
    
  }


  // 1. 지갑 주소로 트랜잭션을 찾을 수 있는가
  // 2. 뭐지?
}
