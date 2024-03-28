import 'package:flutter/material.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:frontend/view_models/block_chain/block_chain_wallet_viewmodel.dart';
import 'package:provider/provider.dart';

class MnemonicRecoveryScreen extends StatelessWidget {
  final focusNodes = List.generate(12, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlockChainWalletViewModel(BlockChainWalletModel()),
      child: Consumer<BlockChainWalletViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: Text('유언장 복구'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 30.0), 
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: viewModel.mnemonicControllers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(
                      ' ${index + 1}번 단어',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextField(
                      controller: viewModel.mnemonicControllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(),
                      onSubmitted: (value) {
                        if (index < 11) {
                          FocusScope.of(context)
                              .requestFocus(focusNodes[index + 1]);
                        }
                      },
                    )
                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (viewModel.validateMnemonic() == 0) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      '경고',
                      textAlign: TextAlign.center,
                    ),
                    content:
                        Text('모든 단어를 입력해주세요.', textAlign: TextAlign.center),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              } else if (viewModel.validateMnemonic() == 1) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      '경고',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      '단어가 유효하지 않습니다.',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              } else {
                await viewModel.recoverFromMnemonic();
              }
            },
            child: Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
