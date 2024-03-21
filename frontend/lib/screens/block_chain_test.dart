import 'package:flutter/material.dart';
import 'package:frontend/models/block_chain_model.dart';
import 'package:provider/provider.dart';
import 'package:frontend/view_models/block_chain/block_chain_viewmodel.dart';

class BlockChainTest extends StatelessWidget {
  const BlockChainTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BlockChainViewModel(BlockChainModel()),
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
                      onPressed: () async {
                        final response = await viewModel.sendTransaction('store', [BigInt.from(35)]);
                        debugPrint('store 함수 호출 결과: $response');
                      },
                      child: Text('store 함수 호출'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final response = await viewModel.retrieve();
                        debugPrint('retrieve 함수 호출 결과: $response');
                      },
                      child: Text('retrieve 함수 호출'),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}