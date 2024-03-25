import 'dart:ffi';

import 'package:frontend/models/block_chain_model.dart';
import 'package:flutter/material.dart'; 


class BlockChainViewModel extends ChangeNotifier{

  

  final BlockChainModel _blockChainModel;
  int _num;
  int get num => _num;
  String newNum = '';
  BlockChainViewModel(this._blockChainModel,{int? num}) : _num = num ?? 0 ;

  Future<String> sendTransaction(String functionName, List<dynamic> params) async {
    final response = await _blockChainModel.sendTransaction(functionName, params);
    debugPrint(response);
    var k = await _blockChainModel.callFunction('retrieve', []);
    k =  k.join();
    debugPrint('엄청 아래임: $k + $response');
    newNum = k;
    notifyListeners();
    debugPrint('음 $newNum $k');
    return response;
  } 


  Future<String> retrieve() async {
    print('retrieve() called');
    var k = await _blockChainModel.callFunction('retrieve', []);
    // debugPrint(k.runtimeType.toString());
    // debugPrint(k.toString());
    newNum = k.join();


    notifyListeners();
    debugPrint('엄청 아래임: $newNum');
    return k.join();
  }

  Future<String> deployContract() {
    return _blockChainModel.deployContract();
  }


  void setNum(int value) {
    _num = value;
    notifyListeners();
  }
  

  
}
