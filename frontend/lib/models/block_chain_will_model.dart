import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/main.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class AudioHash {
  String filePath;
  String fileName;
  DateTime date;
  String hash;

  AudioHash(
      {required this.filePath,
      required this.fileName,
      required this.date,
      required this.hash});
}

class BlockChainWillModel {
  static final storage = FlutterSecureStorage();
  // static final String _contractFilePath = path.join('smart_contract', 'will_system.json');
  static final String _contractFilePath = 'assets/blockchain/will.json';
  // static final Future<String> _ABI = File(_contractFilePath).readAsString();
  static final Future<String> _ABI = rootBundle.loadString(_contractFilePath);
  // static final Future<String> _ABI = File('/smart_contract/will_system.json').readAsString();
  // print(_ABI);
  static const String _contractAddress =
      // '0xed2e8aac38bcddd780bc046f1223296e9ca1d00c'; // 구버전. ipfs 이전
      '0x76F5e6B981e8928ae639B1fe4E13789310F5D887';
   final String _rpcUrl= dotenv.env['RPC_URL']?? ''; // RPC 주소

  static Future<String> get _pk async {
    String? value = await storage.read(key: 'privateKey');
    if (value == null) {
      throw Exception('privateKey not found');
    }
    return value;
  }

  static Future<String> get _address async {
    String? value = await storage.read(key: 'walletAddress');
    if (value == null) {
      throw Exception('walletAddress not found');
    }

    return value;
  }

  static Future<String?> get _userId async {
    String? value = await storage.read(key: 'userId');
    if (value == null) {
      throw Exception('userId not found');
    }

    return value;
  } 


  late Future<String> pk;
  late Future<String> address;
  late Future<String> ABI;

  late Future<String?> userId;

  late Web3Client _client;
  late Credentials _credentials;
  late DeployedContract _contract;

  BlockChainWillModel() {
    init();
  }
  Future<void> init() async {
  userId = BlockChainWillModel._userId;
  // print('userId : $userId');
  pk = BlockChainWillModel._pk;
  var value = await BlockChainWillModel._pk;
  _credentials = EthPrivateKey.fromHex(value);
  ABI = BlockChainWillModel._ABI;


  value = await BlockChainWillModel._ABI;
  _client = Web3Client(_rpcUrl, Client());
  _contract = DeployedContract(
      ContractAbi.fromJson(value, 'WillSystem'),
      EthereumAddress.fromHex(_contractAddress));
  address = BlockChainWillModel._address;
  value = await BlockChainWillModel._address;

  }
  // 트랜잭션 전송
  Future<String> sendTransaction(String txt, String functionName, List params) async {
    final function = _contract.function(functionName);
    final res = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: function,
        parameters: params,
      ),
      fetchChainIdFromNetworkId: false,
      chainId: 31221,
    );
    TransactionReceipt? receipt;
    while (receipt == null) {
      receipt = await _client.getTransactionReceipt(res);
      await Future.delayed(Duration(milliseconds: 500));
      
    }

    if (receipt.status == 0) {
      showSimpleNotification(
        Text('오류가 발생했습니다.', textAlign: TextAlign.center),
        background: themeColour3,
        duration: Duration(seconds: 2),
      );
      throw Exception('Transaction failed');
    }
    // response = 
    showSimpleNotification(
      Text(txt),
      background: themeColour3,
      duration: Duration(seconds: 2),
    );
    return res;
  }

  // 단순 호출
  Future callFunction(String functionName, List<dynamic> params) async {
    final function = _contract.function(functionName);
    final result = await _client.call(
      contract: _contract,
      function: function,
      params: params,
    );
    return result;
  }

}
