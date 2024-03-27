import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:frontend/view_models/block_chain/block_chain_wallet_viewmodel.dart';
import 'package:provider/provider.dart';

class MnemonicShowScreen extends StatefulWidget {
  MnemonicShowScreen({Key? key}) : super(key: key);

  @override
  State<MnemonicShowScreen> createState() => _MnemonicShowScreenState();
}

class _MnemonicShowScreenState extends State<MnemonicShowScreen> {
  final BlockChainWalletViewModel viewModel =
      BlockChainWalletViewModel(BlockChainWalletModel());
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          // Navigator.of(context).pop();
        }
      },
      child: ChangeNotifierProvider.value(
        value: viewModel,
        child: FutureBuilder(
          future: viewModel.createWallet(),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: themeColour2,
                title: Text('유언장 복구 단어'),
                automaticallyImplyLeading: snapshot.connectionState !=
                    ConnectionState.done, // 로딩 완료 시 뒤로가기 버튼 제거
              ),
              body: snapshot.connectionState == ConnectionState.done
                  ? Consumer<BlockChainWalletViewModel>(
                      builder: (context, viewModel, child) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: themeColour1,
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' ${index + 1}번 단어',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    viewModel.mnemonicList[index],
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(themeColour4),
                          ),
                          SizedBox(height: 20),
                          Text('유언장 단어 생성 중입니다. 잠시만 기다려주세요.'),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
