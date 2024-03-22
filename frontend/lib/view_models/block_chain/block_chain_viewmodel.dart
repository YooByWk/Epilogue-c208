import 'dart:ffi';

import 'package:frontend/models/block_chain_model.dart';
import 'package:flutter/material.dart'; 


class BlockChainViewModel extends ChangeNotifier{
  final BlockChainModel _blockChainModel;
  int _num;
  int get num => _num;
  BlockChainViewModel(this._blockChainModel,{int? num}) : _num = num ?? 0;

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


  void setNum(int value) {
    _num = value;
    notifyListeners();
  }
  
}
