import 'package:flutter/material.dart';
import 'package:frontend/models/block_chain_model.dart';
import 'package:frontend/view_models/block_chain/block_chain_wallet_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:frontend/view_models/block_chain/block_chain_viewmodel.dart';
import 'package:frontend/view_models/block_chain/block_chain_wallet_viewmodel.dart';
import 'package:frontend/models/block_chain_wallet_model.dart'; 
import 'package:frontend/view_models/block_chain/block_chain_will_viewmodel.dart';
import 'package:frontend/models/block_chain_will_model.dart';


final walletViewModel = BlockChainWalletViewModel(BlockChainWalletModel());
final audioHashViewModel = AudioHashViewModel();
final willViewmodel = BlockChainWillViewModel();
class BlockChainTest extends StatelessWidget {
  const BlockChainTest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BlockChainViewModel(BlockChainModel(), ),
        child: Consumer<BlockChainViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text('블록체인 테스트'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: ()  async {
                        // debugPrint(await willViewmodel.MyWill());
                        debugPrint(await willViewmodel.SearchByHash());
                      },
                      child : Text('유언 유효성 검사')
                    ),
                    ElevatedButton(
                      onPressed: ()  async {
                        // debugPrint(await willViewmodel.MyWill());
                        debugPrint(await willViewmodel.deleteWill());
                      },
                      child : Text('내 유언 삭제')
                    ),
                    ElevatedButton(
                      onPressed: ()  async {
                        // debugPrint(await willViewmodel.MyWill());
                        debugPrint(await willViewmodel.MyWill());
                      },
                      child : Text('내 유언 확인')
                    ),
                    ElevatedButton(
                      onPressed: () async {    
                        // final response = await willViewmodel.sendTransaction('createWill', [willViewmodel.userId,'testHash']);
                        final res = await willViewmodel.createWill();
                        // final response = await willViewmodel.test();
                        // debugPrint('컨트랙트 배포 결과: $response');
                      },
                      child: Text('꾸욱 배포'),
                    ),
                    Text('값: ${viewModel.num}'),
                    TextFormField(
                      decoration: InputDecoration(labelText: '값 입력'),
                      onChanged: (value) {viewModel.setNum(int.parse(value));
                      debugPrint('입력값: $value');}
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: '유언써보기'),
                      onChanged: (value) {viewModel.setNum(int.parse(value));
                      debugPrint('입력값: $value');}
                    ),
                    ElevatedButton(
                      onPressed: () async {
                         await viewModel.sendTransaction('store', [BigInt.from(viewModel.num *3)]).then((res) async{
                          await viewModel.retrieve();
                          debugPrint('retrieve 함수 호출 결과: ${viewModel.newNum}, $res');
                        });
                        // debugPrint('store 함수 호출 결과: $response');
                        
                      },
                      child: Text('store 함수 호출'),
                    ),
                    Text('Current value : ${viewModel.newNum}'),
                    
                    ElevatedButton(
                      onPressed: () async {
                        final response = await viewModel.retrieve();
                        debugPrint('retrieve 함수 호출 결과: ${viewModel.newNum}, $response');
                      },
                      child: Text('retrieve 함수 호출'),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        debugPrint('지갑 생성 버튼 클릭');
                        // await walletViewModel.createWallet();
                        Navigator.pushNamed(context, '/myMnemonic');

                        // await walletViewModel.createWallet();
                        // debugPrint('지갑 생성 완료');
                      },
                      child : Text('지갑 생성')
                    ),
                    ElevatedButton(
                      onPressed: ()  async {
                       debugPrint(await willViewmodel.storage.read(key : 'privateKey'));
                       debugPrint(await willViewmodel.storage.read(key : 'walletAddress'));
                       debugPrint(await willViewmodel.storage.read(key : 'mnemonic'));
                       debugPrint(await willViewmodel.storage.read(key : 'userId'));
                      },
                      child : Text('지갑 확인')
                    ),

                    ElevatedButton(
                      onPressed: ()  async {
                        Navigator.pushNamed(context, '/mnemonic');
                      },
                      child : Text('니모닉 복구')
                    ),
                    ElevatedButton(
                      onPressed : () {audioHashViewModel.createAudioHash();},
                      child : Text('테스트 파일 해싱')
                    ),
                    ElevatedButton(
                      onPressed : () {audioHashViewModel.checkHash();},
                      child : Text('테스트 파일 해싱')
                    ),

                    
                  ],
                ),
              ),
            );
          },
        ));
  }
}