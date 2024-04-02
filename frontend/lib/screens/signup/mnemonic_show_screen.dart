import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/block_chain_wallet_model.dart';
import 'package:frontend/view_models/block_chain/block_chain_wallet_viewmodel.dart';
import 'package:frontend/widgets/common_text_widget.dart';
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
      canPop: false,
      onPopInvoked: (didPop) {
        debugPrint(didPop.toString());
        // if (didPop) {
          Future.delayed(Duration.zero, () {
            _showBackDialog();
          // });
          // _showBackDialog();
        });
        
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
                // automaticallyImplyLeading: snapshot.connectionState !=
                    // ConnectionState.done, // 로딩 완료 시 뒤로가기 버튼 제거
              ),
              body: snapshot.connectionState == ConnectionState.done
                  ? Consumer<BlockChainWalletViewModel>(
                      builder: (context, viewModel, child) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                  height: MediaQuery.of(context).size.height * 0.65,

                                child: GridView.builder(
                                  key: GlobalKey(),
                                  // height: MediaQuery.of(context).size.height * 0.8,
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
                                        borderRadius: BorderRadius.circular(15.0),
                                        boxShadow: [
                                        BoxShadow(
                                          color: themeColour4.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 1), 
                                        )]
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
                              SizedBox(height: 10),
                              CommonText(text :'유언장을 정상적으로 삭제하고 관리하기 위해 \n    위 단어를 안전한 곳에 보관해주세요.',
                              fontSize: 18.5,
                              isBold: true,
                              textColor: Colors.black87,
                              ),
                            ],
                          ),
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

  void _showBackDialog() {
    debugPrint('뒤로가기 버튼 클릭');
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder : (BuildContext context) {
        return AlertDialog(
          title : Text('경고'),
          content : Text('유언장 단어 확인을 마치시겠습니까?',),
          actions: [
            TextButton(
              onPressed: () => {Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false)},
              // backgroundColor: themeColour5,
              style: TextButton.styleFrom(
              backgroundColor: themeColour1,
                foregroundColor: themeColour3, 

              ),
              child: Text('네', style: TextStyle(color: Colors.black87)),
          ),TextButton(
              onPressed: () => {Navigator.pop(context)},
              style: TextButton.styleFrom(
                shadowColor : themeColour3,
                foregroundColor: themeColour3, 
              ),
              child: Text('아니요',style: TextStyle(color: Colors.grey[500]))
          )
          ],
        );
        
      } 
    );
  } 
}
