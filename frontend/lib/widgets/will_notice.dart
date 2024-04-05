import 'package:flutter/material.dart';

class WillNotice extends StatelessWidget {
  const WillNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '유언 기록 시 주의사항',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 16),
          Text(
          '유언장은 유언의 5가지 형식 중 “녹음에 의한 유언”만 법적 효력을 지닐 수 있습니다.\n\n'
              '녹음 시 주의사항은 다음과 같습니다.\n\n'
              '1. 유언 녹음은 끊김없이 진행되어야 합니다.\n'
              '2. 유언자는 유언의 취지, 성명, 녹음 날짜(연월일)를 필수적으로 언급해야 합니다.\n'
              '3. 증인은 증인 자격 확인 및 유언의 정확함, 성명을 필수적으로 언급해야 합니다.\n',
            style: TextStyle(
              fontSize: 18
            ),
          ),
          Text(
            '주의사항을 숙지하지 않음으로써 발생하는 모든 피해는 본인 책임이며, 에필로그는 피해에 대한 보상을 하지 않습니다.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 18,
          ),
          ),
        ],
      ),
    );
  }
}
