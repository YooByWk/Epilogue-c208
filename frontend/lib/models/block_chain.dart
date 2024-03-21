import 'package:dio/dio.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class BlockChainModel{
  final String _rpcUrl; // RPC 주소
  final String _pk; // 공개키
  final String _contractAddress; // 컨트랙트 주소
  final String _contractAbi; // 컨트랙트 ABI

  late Web3Client _client; // 클라이언트
  late DeployedContract _contract; // 컨트랙트
  late Credentials _credentials; // 자격증명

  BlockChainModel(
    this._rpcUrl, this._pk, this._contractAddress, this._contractAbi
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
      fetchChainIdFromNetworkId : true,
    );
    return response;
  }
}