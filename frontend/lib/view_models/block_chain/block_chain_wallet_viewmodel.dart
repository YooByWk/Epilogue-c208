import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';

class BlcokChainWalletViewModel extends ChangeNotifier {
  WalletModel _walletModel;


 String get walletAddress => _walletModel.walletAddress;

 void createWallet(String address) {
  _walletAddress = address;
  notifyListeners();
 } 

 void checkWallet(String address) {
  _walletModel.checkWallet(address);
  notifyListeners();
 } 
}