import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:web3dart/web3dart.dart';

class BlcokChainWalletViewModel extends ChangeNotifier {

  final BlockChainWalletModel _model = BlockChainWalletModel();
  
  String get walletAddress => _model.walletAddress; 
  String get _privateKey => _model.privateKey;
  bool get hasWallet => _model.hasWallet;

  Future<void> createWallet() async {
    await _model.createWallet();
    notifyListeners();
  }

  Future<void> checkWallet(String address) async{
    await _model.checkWallet(address);
    notifyListeners();
  } 

}