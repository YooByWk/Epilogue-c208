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
