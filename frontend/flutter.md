# 플러터 용어 정리 - 개인

## 그놈의 Prefer const with constant constructors
```yaml
analysis_options.yaml
rules:
  prefer_const_constructors : false
  prefer_const_literals_to_create_immutables: false
  prefer_const_constructors_in_immutables: false

```
굿

## Widget ?
- 플러터는 위젯을 선언 후 동작

### Text
- 위젯   
- 설명 : 

## StatelessWidget
- state 에 변화가 생겨도 바뀌지 않음
## stateful
- state 에 변화가 생기면 같이 빌드됨 
## setState(() {}) 사용.
- state 의 변경에 사용된다
```dart
setState(() {
  customState = '1';
});
```
요롷게.
## Controller ?
- 상태 & 동작 관리 
- UI 요소와 로직 혹은 데이터 사이의 중개
##

##

##

##


## 사용 라이브러리
1. http : 
   > Flutter에서 HTTP 요청을 보내고 받는 데 사용하는 라이브러리.  
   > GET, POST, PUT, DELETE 등의 HTTP 메서드를 사용해 서버와 통신 할 수 있다.  
   > ++  JSON 데이터 가져오기, 파일 업로드, 웹 API 사용하는 작업에 사용된다. 
2. web3dart : 
   > Ethereum blockcahin과 상호작용 하기 위한 dart 라이브러리.    
   > Ethereum 스마트 컨트랙트 배포, 호출, 이벤트 감지, ether 전송, 주소 잔액 확인 등의 작업 수행 가능
3. provider : 
   > Flutter 상태 관리 라이브러리  
4. Crypto : 
   > Dart에서 다양한 암호화 알고리즘 제공  
   > web3dart 를 통해 스마트 컨트랙트를 배포 호출하며, crypto 라이브러리를 통해 데이터 전송 확인
