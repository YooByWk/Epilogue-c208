import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class AudioHash {
  String filePath;
  String fileName;
  DateTime date;
  String hash;

  AudioHash({required this.filePath, required this.fileName, required this.date, required this.hash});
} 

class BlockChainWillModel {
  static final storage = FlutterSecureStorage();
  static  final Future<String> _ABI = File('./smart_contract/will_system.json').readAsString(); 
  static const String _contractAddress = '0x174fBE3C2E97081155c1ef7E44E20337A8F380aA';
  final String  _rpcUrl= 'https://rpc.ssafy-blockchain.com'; // RPC 주소

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

  late Future<String> pk;
  late Future<String> address;
  late Future<String> ABI;

  late Web3Client _client;
  late Credentials _credentials;
  late DeployedContract _contract;


  BlockChainWillModel() {
    pk = BlockChainWillModel._pk;
    address = BlockChainWillModel._address;
    ABI = BlockChainWillModel._ABI;

    pk.then((value) => print('privateKey: $value'));
    address.then((value) => print('walletAddress: $value'));
    ABI.then((value) => print('ABI: $value'));
    
    _client = Web3Client(_rpcUrl, Client());
    _credentials = EthPrivateKey.fromHex(pk.toString());
    _contract = DeployedContract(ContractAbi.fromJson(ABI.toString(), 'WillSystem'), EthereumAddress.fromHex(_contractAddress));
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

    return 'response';
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