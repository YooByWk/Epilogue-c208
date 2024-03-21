import 'package:dio/dio.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class BlockChainModel{
   String _rpcUrl= 'https://rpc.ssafy-blockchain.com'; // RPC 주소
   String _pk = '0xFFEed2e575D8F5D1e390B17A8d39933EFd8200c2'; // 개인키
   String _contractAddress = '0xc5F95849c13cC2b0a0339E594C28079c74183206'; // 컨트랙트 주소
   String _contractAbi ='[ { "inputs": [], "name": "retrieve", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "num", "type": "uint256" } ], "name": "store", "outputs": [], "stateMutability": "nonpayable", "type": "function" } ]'; // 컨트랙트 ABI

  late Web3Client _client; // 클라이언트
  late DeployedContract _contract; // 컨트랙트
  late Credentials _credentials; // 자격증명

  BlockChainModel(
    // this._rpcUrl, this._pk, this._contractAddress, this._contractAbi
  ) {
    _client =  Web3Client(_rpcUrl, Client()); 
    _credentials = EthPrivateKey.fromHex(_pk);

    debugPrint(_credentials.address.hex);
    _contract = DeployedContract(
      ContractAbi.fromJson(_contractAbi, '블록체인 테스트'),
      EthereumAddress.fromHex(_contractAddress)
    );
  }

  Future<String> sendTransaction(String functionName, List<dynamic> params) async {
    final function = _contract.function(functionName);
    final response = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(contract: _contract, function: function, parameters: params),
      fetchChainIdFromNetworkId : false,
      chainId: 31221,
    );
    return response;
  }

  Future<String> callFunction(String functionName, List<dynamic> params) async {
    final function = _contract.function(functionName);
    final response = await _client.call(
      contract: _contract,
      function: function,
      params: params,
    );
    return response.toString();
  }
}