import 'package:dio/dio.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:convert/convert.dart';



class BlockChainModel{
   final String _rpcUrl= dotenv.env['RPC_URL']?? ''; // RPC 주소
   String _pk = '0xFFEed2e575D8F5D1e390B17A8d39933EFd8200c2'; // 개인키
   String _contractAddress = '0xc5F95849c13cC2b0a0339E594C28079c74183206'; // 컨트랙트 주소
   String _contractAbi ='[ { "inputs": [], "name": "retrieve", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "num", "type": "uint256" } ], "name": "store", "outputs": [], "stateMutability": "nonpayable", "type": "function" } ]'; // 컨트랙트 ABI
  
  late String _newAddress;
  // String _newAbi = '[ { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "inputs": [ { "internalType": "uint128", "name": "_number", "type": "uint128" } ], "name": "addNumberList", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "checkActivated", "outputs": [ { "internalType": "uint128", "name": "", "type": "uint128" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint128", "name": "_number", "type": "uint128" } ], "name": "checkNumber", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getNumber", "outputs": [ { "internalType": "uint128", "name": "", "type": "uint128" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getNumberList", "outputs": [ { "internalType": "uint128[]", "name": "", "type": "uint128[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint128", "name": "_number", "type": "uint128" } ], "name": "setNumber", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "nonpayable", "type": "function" } ]';
  String _newAbi = '[ { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "inputs": [ { "internalType": "uint128", "name": "_number", "type": "uint128" } ], "name": "addNumberList", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "checkActivated", "outputs": [ { "internalType": "uint128", "name": "", "type": "uint128" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint128", "name": "_number", "type": "uint128" } ], "name": "checkNumber", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getNumber", "outputs": [ { "internalType": "uint128", "name": "", "type": "uint128" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "getNumberList", "outputs": [ { "internalType": "uint128[]", "name": "", "type": "uint128[]" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint128", "name": "_number", "type": "uint128" } ], "name": "setNumber", "outputs": [ { "internalType": "string", "name": "", "type": "string" } ], "stateMutability": "nonpayable", "type": "function" } ]';
  String _newByteCode ='60806040526000600360006101000a8154816fffffffffffffffffffffffffffffffff02191690836fffffffffffffffffffffffffffffffff16021790555034801561004a57600080fd5b50336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555061091d8061009a6000396000f3fe608060405234801561001057600080fd5b50600436106100625760003560e01c80633232b962146100675780633bfe08f8146100975780633e5f6bd6146100c75780637d7d2427146100e3578063bcb659a414610101578063f2c9ecd81461011f575b600080fd5b610081600480360381019061007c91906105e2565b61013d565b60405161008e919061069f565b60405180910390f35b6100b160048036038101906100ac91906105e2565b6102a8565b6040516100be919061069f565b60405180910390f35b6100e160048036038101906100dc91906105e2565b610351565b005b6100eb6104ad565b6040516100f891906106d0565b60405180910390f35b6101096104d3565b60405161011691906107a9565b60405180910390f35b61012761056f565b60405161013491906106d0565b60405180910390f35b606060008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16146101cd576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016101c49061083d565b60405180910390fd5b81600160006101000a8154816fffffffffffffffffffffffffffffffff02191690836fffffffffffffffffffffffffffffffff1602179055506003600081819054906101000a90046fffffffffffffffffffffffffffffffff16809291906102349061088c565b91906101000a8154816fffffffffffffffffffffffffffffffff02191690836fffffffffffffffffffffffffffffffff160217905550506040518060400160405280601f81526020017fec88abec9e90eab08020eca080ec9ea5eb9098ec9788ec8ab5eb8b88eb8ba4008152509050919050565b6060816fffffffffffffffffffffffffffffffff16600160009054906101000a90046fffffffffffffffffffffffffffffffff166fffffffffffffffffffffffffffffffff1603610330576040518060400160405280601981526020017fec88abec9e90eab08020ec9dbcecb998ed95a9eb8b88eb8ba400000000000000815250905061034c565b6040518060600160405280602381526020016108c56023913990505b919050565b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16146103df576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016103d69061083d565b60405180910390fd5b60028190806001815401808255809150506001900390600052602060002090600291828204019190066010029091909190916101000a8154816fffffffffffffffffffffffffffffffff02191690836fffffffffffffffffffffffffffffffff1602179055506003600081819054906101000a90046fffffffffffffffffffffffffffffffff16809291906104739061088c565b91906101000a8154816fffffffffffffffffffffffffffffffff02191690836fffffffffffffffffffffffffffffffff1602179055505050565b6000600360009054906101000a90046fffffffffffffffffffffffffffffffff16905090565b6060600280548060200260200160405190810160405280929190818152602001828054801561056557602002820191906000526020600020906000905b82829054906101000a90046fffffffffffffffffffffffffffffffff166fffffffffffffffffffffffffffffffff1681526020019060100190602082600f010492830192600103820291508084116105105790505b5050505050905090565b6000600160009054906101000a90046fffffffffffffffffffffffffffffffff16905090565b600080fd5b60006fffffffffffffffffffffffffffffffff82169050919050565b6105bf8161059a565b81146105ca57600080fd5b50565b6000813590506105dc816105b6565b92915050565b6000602082840312156105f8576105f7610595565b5b6000610606848285016105cd565b91505092915050565b600081519050919050565b600082825260208201905092915050565b60005b8381101561064957808201518184015260208101905061062e565b60008484015250505050565b6000601f19601f8301169050919050565b60006106718261060f565b61067b818561061a565b935061068b81856020860161062b565b61069481610655565b840191505092915050565b600060208201905081810360008301526106b98184610666565b905092915050565b6106ca8161059a565b82525050565b60006020820190506106e560008301846106c1565b92915050565b600081519050919050565b600082825260208201905092915050565b6000819050602082019050919050565b6107208161059a565b82525050565b60006107328383610717565b60208301905092915050565b6000602082019050919050565b6000610756826106eb565b61076081856106f6565b935061076b83610707565b8060005b8381101561079c5781516107838882610726565b975061078e8361073e565b92505060018101905061076f565b5085935050505092915050565b600060208201905081810360008301526107c3818461074b565b905092915050565b7fec82acec9aa9ec9e9020eca095ebb3b4eab08020ec9dbcecb998ed9598eca78060008201527f20ec958aec8ab5eb8b88eb8ba400000000000000000000000000000000000000602082015250565b6000610827602d8361061a565b9150610832826107cb565b604082019050919050565b600060208201905081810360008301526108568161081a565b9050919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b60006108978261059a565b91506fffffffffffffffffffffffffffffffff82036108b9576108b861085d565b5b60018201905091905056feec88abec9e90eab08020ec9dbcecb998ed9598eca78020ec958aec8ab5eb8b88eb8ba4a26469706673582212207a5dfac803cbd2653018ff48bddf6875f5b54470f31025bc04fb4adfc57ee23864736f6c63430008120033';
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



Future<String> deployContract() async {
  String _rpcUrl = 'https://rpc.ssafy-blockchain.com'; // RPC 주소
  String _pk = '0xFFEed2e575D8F5D1e390B17A8d39933EFd8200c2'; // 개인키

  final client = Web3Client(_rpcUrl, Client(), );
  final credentials = await EthPrivateKey.fromHex(_pk);

  final contractAbi = ContractAbi.fromJson(_newAbi, '실습용 컨트랙트');

  final transaction = Transaction(
    from: credentials.address,
    to: null,
    gasPrice: EtherAmount.zero(),
    maxGas: 3000000,
    value: EtherAmount.zero(),
    data: Uint8List.fromList(hex.decode(_newByteCode)),
  );

  final response = await client.sendTransaction(
    credentials,
    transaction,
    fetchChainIdFromNetworkId: false,
    chainId: 31221,
  );

  TransactionReceipt? receipt;
  while (receipt == null) {
    await Future.delayed(Duration(seconds: 1));
    receipt = await client.getTransactionReceipt(response);
  }

  _newAddress = receipt.contractAddress?.hex.toString() ?? '없는뎁쇼';
  debugPrint(receipt.toString());
  if (_newAddress == null) {
    throw Exception('Contract was not created.');
  }

  debugPrint(receipt.toString());
  return _newAddress;
}

///////////////////////////////////////

  Future<String> sendTransaction(String functionName, List<dynamic> params) async {
    final function = _contract.function(functionName);
    final response = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(contract: _contract, function: function, parameters: params),
      fetchChainIdFromNetworkId : false,
      chainId: 31221,
    );

      TransactionReceipt? receipt;
      while (receipt == null) {
        await Future.delayed(Duration(seconds: 1));
        receipt = await _client.getTransactionReceipt(response); 
      }

      if (receipt.status == 0) {
        throw Exception('Transaction failed');
      }

      if (receipt.contractAddress != null) {
        _newAddress = receipt.contractAddress!.hex;
      }

      debugPrint('$receipt.status.toString() 주소');

    return response;
  }

  Future callFunction(String functionName, List<dynamic> params) async {
    final function = _contract.function(functionName);
    final response = await _client.call(
      contract: _contract,
      function: function,
      params: params,
    );
    return response;
  }
}