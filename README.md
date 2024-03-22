# E:pilogue
## 블록체인 기반의 디지털 유언 생성 및 디지털 추모관 제공 플랫폼

- front-test 브랜치 > frontend 폴더 > z_docs 폴더 확인<br>
[바로가기](https://lab.ssafy.com/s10-blockchain-contract-sub2/S10P22C208/-/tree/front-test/frontend/z_docs?ref_type=heads)

---

# CI/CD

### Docker에서 Jenkins 설치

<aside>
💡 docker가 이미 서버에 설치되어 있는 가정 하에 진행

</aside>

- docker container에 마운트할 볼륨 디렉토리 생성

```jsx
$ cd /home/ubuntu && mkdir jenkins-data
```

- 외부에서 접속할 포트 오픈하고 상태 확인

```jsx
$ sudo ufw allow 9999
$ sudo ufw reload
$ sudo ufw status

Status: active

To                         Action      From
--                         ------      ----
22                         ALLOW       Anywhere
8989                       ALLOW       Anywhere
443                        ALLOW       Anywhere
80                         ALLOW       Anywhere
3306                       ALLOW       Anywhere
8888                       ALLOW       Anywhere
9999                       ALLOW       Anywhere
22 (v6)                    ALLOW       Anywhere (v6)
8989 (v6)                  ALLOW       Anywhere (v6)
443 (v6)                   ALLOW       Anywhere (v6)
80 (v6)                    ALLOW       Anywhere (v6)
3306 (v6)                  ALLOW       Anywhere (v6)
8888 (v6)                  ALLOW       Anywhere (v6)
9999 (v6)                  ALLOW       Anywhere (v6)
```

### 1) Jenkins 이미지 내려받기

- Docker Hub에서 Jenkins 이미지 내려받기

```jsx
$ sudo docker pull jenkins/jenkins:jdk17
// jenkins:lts는 jdk8로 실행이 되기 때문에 jdk17로 지정
```

### 2) Jenkins 이미지 컨테이너로 실행

```jsx
$ sudo docker run -d -p 9999:8080 -v /home/ubuntu/jenkins-data:/var/jenkins_home --name jenkins -u root jenkins/jenkins:jdk17
// -d : background에서 실행 (background에서 실행하지 않으면 메인으로 실행되어 다른 컨테이너가 중지된다.)
// -p : 포트 포워딩
// **볼륨 마운트**(호스트의 파일 시스템 경로를 컨테이너 내부에 연결하는 것)를 해주어야 원하는 위치에 파일들을 생성할 수 있다.
```

이때, `9999:8080`의 `9999`는 호스트 포트 번호, `8080`은 컨테이너 포트번호다.

이는 `9999`번 포트에 접속하게 되면 `8080`번 컨테이너 포트로 접속하게 된다는 뜻이며 호스트 포트 번호는 중복되면 안되지만 컨테이너는 각각의 포트가 따로 있으므로 겹쳐도 된다.

`9000:8080`으로 A 컨테이너를 만들었을 경우 `9001:8080`으로 B 컨테이너를 만들어도 된다는 뜻이다!


- 일부 환경 설정 변경을 위해 docker container를 종료하고 상태 확인

```jsx
$ sudo docker stop jenkins
$ sudo docker ps -a
```

### 3) 환경 설정 변경 ★★

- `jenkins-data` 폴더로 이동

```jsx
$ sudo cd /home/ubuntu/jenkins-data
```

- `update-center-rootCAs` 폴더 생성 및 update center에 필요한 CA 파일 다운로드

```jsx
$ sudo mkdir update-center-rootCAs
$ sudo wget https://cdn.jsdelivr.net/gh/lework/jenkins-update-center/rootCA/update-center.crt -O ./update-center-rootCAs/update-center.crt
```

- jenkins의 default 설정에서 특정 미러 사이트로 대체하도록 명령어 실행

```jsx
$ sudo sed -i 's#https://updates.jenkins.io/update-center.json#https://raw.githubusercontent.com/lework/jenkins-update-center/master/updates/tencent/update-center.json#' ./hudson.model.UpdateCenter.xml
// 해당 파일의 특정 부분을 입력한 문자열로 대체하겠다는 뜻이다.
```

### 4) Jenkins 초기 설정

`http://<EC2 도메인네임>:설정한젠킨스포트`로 접속

⇒ `http://j10c208.p.ssafy.io:9999`

- `sudo docker logs jenkins` 입력 시 나오는 비밀번호 확인! (★★ 따로 적어놓기 : `9d333402e6bc4fa9b6c667eb53b65a10`)

(1) Install suggested plugins 선택

(2) admin 계정 설정

- 계정명 : `epilogue`
- 암호 : shgrhshfdk@

(3) 외부 접속 URL 설정

- `http://j10c208.p.ssafy.io:9999`

## Jenkins Pipieline 작성

```bash
pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
                // Git 저장소에서 소스 코드를 가져옵니다.
                echo 'Git Clone'
                git branch: 'backend', credentialsId: 'epilogue', url: 'https://lab.ssafy.com/s10-blockchain-contract-sub2/S10P22C208.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Build'
                dir('backend/epilogue') {
                    sh 'chmod +x ./gradlew'
                    sh './gradlew clean build' // 기존 파일을 지우고 gralde로 프로젝트 새로 빌드
                }
            }
        }

        stage('Deploy') {
            steps {
                // 스프링 도커 컨테이너 중지
                sh 'docker stop spring-docker || true'
                // 스프링 도커 컨테이너 제거
                sh 'docker rm spring-docker || true'
                // 스프링 이미지 삭제
                sh 'docker rmi spring || true'

                // 스프링 이미지 빌드(생성)
//                 <1번 방법>
//                 dir('backend/epilogue') {
//                    sh 'docker build -t spring .'
//                 }
//                 <2번 방법>
//                 sh 'docker build -t spring ./build/libs/epilogue-0.0.1-SNAPSHOT.jar'
//                 <3번 방법>
//                 sh 'pwd' // jenkins-data/workspace/Epilogue_Backend
                  sh 'docker build -t spring ./backend/epilogue' // backend/epilogue 들어가서 spring 이미지 생성
//                 sh 'ls -al'

                // 스프링 도커 컨테이너 실행
                sh 'docker run -d -p 8080:8080 --name spring-docker spring'
            }
        }
    }
}
```

# Backend

## 완성된 API

### 회원

- 회원가입
- 로그인
- 카카오 로그인
- 네이버 로그인
- 비밀번호 변경
- 회원 정보 조회
- 회원 정보 수정
- 회원 탈퇴

### 유언

- 나의 유언 조회
- 나의 유언 삭제
- 유언 작성
- 유언 열람 신청
