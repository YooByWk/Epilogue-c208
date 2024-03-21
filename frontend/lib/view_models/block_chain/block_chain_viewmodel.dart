import 'package:frontend/models/block_chain_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart'; 


class BlockChainViewModel extends ChangeNotifier{
  final BlockChainModel _blockChainModel;
  BlockChainViewModel(this._blockChainModel);

  Future<String> sendTransaction(String functionName, List<dynamic> params) async {
    final response = await _blockChainModel.sendTransaction(functionName, params);
    notifyListeners();
    return response;
  } 

  Future<String> retrieve() {
    return _blockChainModel.callFunction('retrieve', []);
  }

  Future<String> deployContract() {
    return _blockChainModel.deployContract();
  }
}
