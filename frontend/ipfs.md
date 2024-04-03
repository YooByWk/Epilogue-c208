# ipfs 

## 목표
현재 flutter 앱에서 생성된 녹음 파일을 블록체인에 해싱하고, 추가적으로 프론트가 ipfs에 파일을 저장한다.


## 사용한 것
1. flutter dart
2. solidity
3. Ethereum ERC20, BIP32, BIP39
4. ipfs

## 과정
1. 도커에 ipfs 설치
  
```bash
docker pull ipfs/go-ipfs
```


2. 매핑

```bash
docker run -d --name ipfs_host -v /path/to/ipfs/staging:/export -v /path/to/ipfs/data:/data/ipfs -p 5000:4001 -p 5001:8080 -p 5002:5001 ipfs/go-ipfs:latest
```
포트 설명 
      1. 5000 : 기존의 4001 포트 IPFS 노드 간 피어 통신 
      2. 5002 : 기존의 5001 IPFS노드와 로컬 애플리케이션 간 통신 포트
      3. 5001 : 기존의 8080 IPFS HTTP API 접근 포트

1. 데몬 실행

```bash
docker exec -it ipfs_host ipfs daemon


# 설정하러 떠나봅시다.
# IPFS 데몬 중지
docker exec -it ipfs_host ipfs shutdown

# config 파일 수정
docker exec -it ipfs_host vi /data/ipfs/config

# Docker 컨테이너 재시작
docker restart ipfs_host

``` 
앗!!!! 

4. 도커에서 들어가서 config를 수정해줘야 한다. 

```bash 
docker exec -it ipfs_host sh # 도커 

vi /data/ipfs/config # 설정 파일 
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]' # CORS 
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]' # 

docker restart ipfs_host # 도커 ipfs 재시작
```

5. 5002 포트에 가서 ipfs 확인
5002/webui

![alt text](image.png)


6. GUI는 ipfs 이하의 파일만 보여주므로 업로드 되더라도 바로 반영되지 않습니다. 
> 해당 사항을 반영하기 위해서는 ipfs 에 접근해 ipfs files cp /ipfs/QmThing /파일명 명령을 실행합니다.
>
> 다만 MFS(Mutable File System)에 복사본 파일을 다시 저장하는 것으로 저장공간에 손해가 발생합니다.