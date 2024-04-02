import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:frontend/view_models/block_chain/block_chain_wallet_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:frontend/main.dart';

class MnemonicRecoveryScreen extends StatelessWidget {
  final focusNodes = List.generate(12, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlockChainWalletViewModel(BlockChainWalletModel()),
      child: Consumer<BlockChainWalletViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text('유언장 복구'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Padding(
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
                        return Container(
                            decoration: BoxDecoration(
                                color: themeColour1,
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: themeColour4.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 1),
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 15.5),
                                Text(
                                  ' ${index + 1}번 단어',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextField(
                                    controller:
                                        viewModel.mnemonicControllers[index],
                                    focusNode: focusNodes[index],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          // style: BorderStyle.dotted,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    onSubmitted: (value) {
                                      if (index < 11) {
                                        FocusScope.of(context)
                                            .requestFocus(focusNodes[index + 1]);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spa
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: CommonButtonWidget(
                        text: '새로운 유언장 코드 발급',
                        width: 250,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('새로운 유언장 코드 발급'),
                              content: Text('새로 발급시 기존 유언장에 대한 유효성은 확인할 수 없어요.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('취소',style: TextStyle(color: Colors.grey[500])),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/myMnemonic');
                                  },
                                  child: Text('실행',style: TextStyle(color: themeColour5)),
                                ),
                              ],
                            ),
                          );
                        },
                        // child: Text('새로운 유언장 코드 발급'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: themeColour2,
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
                        child: Text('확인',style: TextStyle(color: Colors.grey[600])),
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
                        child: Text('확인',style: TextStyle(color: Colors.grey[600])),
                      ),
                    ],
                  ),
                );
              } else {
                await viewModel.recoverFromMnemonic();
                Navigator.pushNamed(context, '/home');
              }
            },
            child: Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
