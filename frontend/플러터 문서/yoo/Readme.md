# 작업 내역

## 개인기록용 / 

# ~3월 22일

## 목차
- 개발 가이드라인 작성
- 추모관 화면 구성
- 블록체인 - 스마트 컨트랙트 

<details>
<summary>
프론트엔드 Read.me 작성 : 개발 가이드라인 
</summary>
<div markdown='1'>

# 개발 가이드
> 개인 학습 겸 쓰여진 가이드입니다.
>
> 따르면 나쁠건 없고, 안따라도 문제없습니다 굿  


![alt text](5mins.png)

## 네이밍 컨벤션

1. 폴더 이름에는 대문자를 사용하지 않습니다. 
2. 변수와 함수 이름은 `lowerCamelCase`를 사용합니다.
3. 클래스 이름은 `UpperCamelCase`를 사용합니다.
4. 상수는 `UPPERCASE_WITH_UNDERSCORES`를 사용합니다.

```dart
//클래스
class UserProfile {
  // 변수 이름 
  final String userName;
  final String userEmail;
  // 상수 예시
  static const int MAX_LOGIN_ATTEMPTS = 5; 

  // 생성자
  UserProfile(this.userName, this.userEmail);

  // 메서드 (lowerCamelCase)
  void displayUserInfo(){
    print('유저 : $userName\n 이메일 : $userEmail');
  }
}
```

## 코드 포멧팅
1. 한 줄은 80~100자 미만으로 작성합니다.
2. 일반적인 경우로 기본적으로 제공되는 IDE의 자동완성 혹은 `dartfmt`를 따릅니다.


## 폴더구조
> 이 폴더 구조의 규칙은 "Memorial, Will, Main" 등 기능단위 기준으로 구분하는 규칙보다 우선되지는 않습니다. 
>
> 추후 협의 예정입니다. 자율적인 판단, 실행을 권장/존중합니다.



1. 폴더는 기본적으로 models, view_models, view로 구성되는 것이 바람직합니다.  이는 MVVM 패턴을 따르는 각 구성 요소를 의미합니다.
   - `models` :  데이터를 나타내는 클래스를 포함합니다.
   - `view_models` : 상태 관리와 로직을 처리하는 클래스를 포함합니다.
   - `views` : 사용자 인터페이스를 구성하는 위젯을 포함합니다. 

2. `widgets` : 공통적으로 사용되는 위젯이 자리하게 됩니다.
  - 위젯의 사용에 관한 주석을 권장합니다.
  - 위젯의 필수요소와 선택사항의 기록 또한 권장합니다.

```
/lib
  /models
    - user_model.dart
  /view_models
    - user_view_model.dart
  /views
    - user_profile_page.dart
  /widgets
    - custom_button.dart
```


### MVVM 패턴
> 과감히 건너뛰는 것 또한 하나의 방법
```dart
// Model : 데이터를 나타냅니다.
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

// ViewModel : 상태 관리와 로직을 처리합니다.
class UserViewModel with ChangeNotifier {
  User _user = User(name: 'Initial Name', email: 'Initial Email');

  User get user => _user;

  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}

// View  : 사용자 인터페이스를 나타냅니다.
class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: Consumer<UserViewModel>(
          builder: (context, viewModel, child) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text('Name: ${viewModel.user.name}'),
                Text('Email: ${viewModel.user.email}'),
                ElevatedButton(
                  onPressed: () {
                    // Update user info
                    viewModel.updateUser(
                      User(name: 'Updated Name', email: 'Updated Email'),
                    );
                  },
                  child: Text('Update Info'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
> 해당 코드는 사용자의 이름과 이메일을 표시하는 간단한 사용자 프로필을 나타내고 있습니다. 이것을 표현하기 위해 `ChangeNotifier`와 `Consumer`가 사용되었습니다.


## 주석 //
주석의 사용은 **권장**됩니다.   
클래스의 사용과 기능에 대한 주석은 코드 유지보수를 위한 이해 과정에 효과적이리라 예상합니다.


## 라이브러리 / plugins
> 사용을 말리지 않습니다.   
> 하지만 무분별한 추가는 사양합니다.



## 상태관리 with provider

1. 상태를 가진 클래스는 `ChangeNotifier를` 확장합니다. 상태가 변경될 때마다 `notifyListeners()`를 호출하여 상태 변경을 알립니다.
2. `ChangeNotifierProvider는` `ChangeNotifier를` 제공하는 위젯입니다. 이를 사용하여 상태를 가진 객체를 위젯 트리에 제공합니다.
3. `Consumer는` `ChangeNotifierProvider로부터` 상태를 소비하는 위젯입니다. 상태가 변경될 때마다 자동으로 다시 빌드됩니다.
4. `Selector는` `Consumer와` 유사하지만, 특정 상태 변경에만 반응하도록 설정할 수 있습니다.

```dart
// 상태를 가진 클래스 예시 - viewModel
class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    // 상태가 변경될 때 마다 리스너들에게 알립니다.
    notifyListeners(); 
  }
}

// 상태를 제공하는 위젯 예시
class CounterProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: CounterPage(),
    );
  }
}

// 상태를 소비하는 위젯 예시 view
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Example'),
      ),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context, counter, child) => Text('Count: ${counter.count}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 상태 변경
          context.read<CounterModel>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

```

## 에러 처리
`try-catch`를 블록을 통해 오류 메시지를 표시합니다.

```dart
  try {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/컨벤션.txt';
  final file = File(filePath);
  String fileContents = await file.readAsString();
  print(fileContents);
  } catch (e) {
  print('An error occurred: $e');
  }
```

2024_03_16 작성.
2024_03_17 00:38 최종수정.
2024_03_22 Readme.md 제출
</div>
</details>


작업 내역 : 

- 
  
<details>

<summary>
디지털 추모관 화면 구성
</summary>

> model 작업 필요한 상황입니다.

## veiw

1. 각 탭(사진, 동영상, 편지) 기본 레이아웃 구성
   
2. 사진
   1.  무한 스크롤 구현 (SliverGrid) 
   2.  LongPress를 통한 이미지 미리보기 오버레이 구현
   3.  BE 와 testApi 를 통한 api 호출 확인

3. 동영상
   1.  화면 중앙 동영상 자동 재생
   2.  동영상 썸네일 제공
   3.  LongPress 를 통한 일시 정지 
   4.  tap 하여 정지 
   5.  무한스크롤 (ListView)

4. 편지
   1. 무한스크롤 구현 (SliverGrid) 

</details>

---

<details>

<summary>
  flutter api 호출 예시 파일 작성
</summary>

- dart에서 제공하는 http가 아닌 dio를 사용해 api 호출을 진행합니다.
-  Json 자료 처리가 간편해집니다!

```dart

// frontend/lib/dio_api_request_examples.dart

import 'package:flutter/material.dart'; //debugPrint 사용 위함
import 'package:dio/dio.dart'; // Dio 사용 위함 

// Dio는 HTTP 클라이언트로서, Dart 언어로 작성된 비동기 HTTP 클라이언트 프레임워크.

class DioExamples {
final dio = Dio(); // 
void GetRequest() async {
  Response response = await dio.get('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void PostRequest() async {
  Response response = await dio.post('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void PutRequest() async {
  Response response = await dio.put('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void DeleteRequest() async {
  Response response = await dio.delete('http://j10c208.p.ssafy.io:8080/api/test');
  debugPrint(response.data.toString());
}

void DownloadRequest() async {
  Response response = await dio.download('http://j10c208.p.ssafy.io:8080/api/test', 'downloadPath');
  debugPrint(response.data.toString());
}
// 대충 이런식으로 사용하면 됩니다.

/* Dio의 Response 구성
final response = await dio.get('https://pub.dev');
print(response.data);
print(response.headers);
print(response.requestOptions);
print(response.statusCode);
*/

// dio의 주요 메서드
// get, post, put, delete, download, head, patch, request
// 이 중에서 get, post, put, delete, download를 사용하면 됩니다.
// https://pub.dev/packages/dio 참고
}
```

</details>

---

<details>

<summary>
  블록체인 스마트 컨트랙트 테스트 배포
</summary>

### remix ide 배포 후 트랜잭션 확인
.sol : 실습용 스마트 컨트랙트

```solidity
// frontend/smart_contract/test.sol
// SPDX-License-Identifier: MIT
pragma solidity =0.8.18;

contract Test {

  address owner;
  uint128  number;
  uint128[] numberList; 
  uint128 isActivated = 0;

  constructor() {
    owner = msg.sender;
  }  

  modifier onlyOwner() {
    require (msg.sender == owner, unicode"사용자 정보가 일치하지 않습니다");
    _;
  }

  function setNumber(uint128 _number) public onlyOwner returns (string memory) {
    number = _number;
    isActivated++;

    return unicode"숫자가 저장되었습니다";
  }

  function checkNumber(uint128 _number) public view returns (string memory) {
    if (number == _number) {
      return unicode"숫자가 일치합니다";
    } else {
      return unicode"숫자가 일치하지 않습니다";
    }
  }

  function getNumber() public view returns (uint128) {
    return number;
  }

  function addNumberList(uint128 _number) public onlyOwner {
    numberList.push(_number);
    isActivated++;
  }

  function getNumberList() public view returns (uint128[] memory) {
    return numberList;
  }
  
  function checkActivated() public view returns(uint128) {
    return isActivated;
  } 
}
```

### flutter app 내부 트랜잭션 확인
1. flutter app 내부 블록체인 테스트 페이지에서 버튼 클릭시 디버그 콘솔에 입력됩니다.
2. remix ide에서 컨트랙트 주소를 통해 트랜잭션의 확인이 가능합니다.

### flutter app 내부 스마트 컨트랙트 배포 확인
1. 개인지갑을 통한 테스트 컨트랙트 배포
2. remix Ide 를 통한 Abi, bytecode 복사 후 입력
3. 디버그 콘솔 or remix Ide 에서 컨트랙트 주소를 통해 사용/확인 가능합니다.

</details>