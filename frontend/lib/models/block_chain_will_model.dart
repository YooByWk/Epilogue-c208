import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show rootBundle;

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
      '0x174fBE3C2E97081155c1ef7E44E20337A8F380aA';
  final String _rpcUrl = 'https://rpc.ssafy-blockchain.com'; // RPC 주소

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
  print('userId : $userId');
  pk = BlockChainWillModel._pk;
  var value = await BlockChainWillModel._pk;
  _credentials = EthPrivateKey.fromHex(value);

  value = await BlockChainWillModel._ABI;
  _client = Web3Client(_rpcUrl, Client());
  _contract = DeployedContract(
      ContractAbi.fromJson(value, 'WillSystem'),
      EthereumAddress.fromHex(_contractAddress));

  value = await BlockChainWillModel._address;
  // print('walletAddress????: $value');
  // print('contract : $_contract');
  
    // pk = BlockChainWillModel._pk;

    // address = BlockChainWillModel._address;
    // ABI = BlockChainWillModel._ABI;

    // // 유효한 키를 설정하자
    // pk.then((value) { 
    //   _credentials = EthPrivateKey.fromHex(value);
    // });
    // // ABI를 설정하자
    // ABI.then((value) {
    // _client = Web3Client(_rpcUrl, Client());
    // _contract = DeployedContract(
    //     ContractAbi.fromJson(value, 'WillSystem'),
    //     EthereumAddress.fromHex(_contractAddress));
    // // print('contract : $_contract');
    // });

    // address.then((value) => print('walletAddress????: $value'));

    // // _client = Web3Client(_rpcUrl, Client());
    // // _contract = DeployedContract(
    // //     ContractAbi.fromJson(ABI.toString(), 'WillSystem'),
    // //     EthereumAddress.fromHex(_contractAddress));
  }
  // 트랜잭션 전송
  Future<String> sendTransaction(String functionName, List<dynamic> params) async {
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
      throw Exception('Transaction failed');
    }
    // response = 
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
