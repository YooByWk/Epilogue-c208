<<<<<<< HEAD
# Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.

You don't have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn't feel obligated to use this feature. However we understand that this tool wouldn't be useful if you couldn't customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
=======
# 개발 가이드
> 개인 학습 겸 쓰여진 가이드입니다.
>
> 따르면 나쁠건 없고, 안따라도 문제없습니다 굿  


![alt text](5mins.png)
## .env 파일 관련
- .env.example 파일을 복사해서 자신만의 .env 파일을 만들고, 필요한 환경 변수 값을 채워 넣음
```
cp .env.example .env
```

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
>>>>>>> 89bb60f2156c9bbb8fe8a70025ca5a804eddd590
