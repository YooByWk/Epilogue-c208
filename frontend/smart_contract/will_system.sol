// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract WillSystem {

    address admin;
    constructor() {
        admin = msg.sender;    
    }

    modifier onlyAdmin () {
        require (admin == msg.sender);
        _;
    }

    // 유언장 구조체
    struct Will {
        string userId;
        string fileHash;
        uint createdAt;
        // IPFS 해시값
        string ipfsHash;
    }

    // 이력 추적용 구조체
    struct History {
        string eventType;
        uint256 timestamp;
        address userAddress;
        string userId;
    }

    History[] public logs;

    mapping(address => string) public addressToUserId; // 하나의 주소는 하나의 아이디
    mapping(address => Will) public addressToWill; // 하나의 주소는 하나의 유언장
    mapping(string => Will[]) public userIdToWills; // 하나의 유저 아이디는 여러개의 유언장 이력을 가진다. 이 부분은 계속해서 남는다.
    mapping(string => Will) public hashToWill; // 하나의 해시값은 하나의 유언장
    mapping(string => History[]) public userToHistroy; // 한 유저는 여러 이력
    mapping(string => address) public userIdToaddress; // 유저 아이디로 주소를 찾음

    // IPFS 해시값을 저장하는 매핑
    // mapping(string => string) public userIdToIpfsHash; // 유저 아이디로 ipfs 해시값을 찾음
    // mapping(address => string) public addressToIpfsHash; // 주소로 ipfs 해시값을 찾음

    function createWill(string memory userId, string memory fileHash, string memory ipfsHash) public {
        // 0. 유언장 정보 등록
        Will memory newWill = Will({
            userId: userId,
            fileHash: fileHash,
            createdAt: block.timestamp,
            ipfsHash : ipfsHash
        });

        // 1. 유저를 등록한다
        addressToUserId[msg.sender] = userId;
        userIdToaddress[userId] = msg.sender;
        // 2. 주소와 유언 매핑
        addressToWill[msg.sender] = newWill;
        // 3. 아이디와 유언 매핑
        userIdToWills[userId].push(newWill);
        // 4. 헤시와 유언 매핑
        hashToWill[fileHash] = (newWill);
        // 5. 기록을 추가한다.
        logHistory(userId, unicode"유언 생성");

        History memory userHistory = History({
            eventType : unicode'유언 생성',
            timestamp: block.timestamp,
            userId: userId,
            userAddress : msg.sender
        });
        // 6. 유저 로그에 추가한다.
        userToHistroy[userId].push(userHistory);
        // 반환한다.
    }

    function logHistory(string memory userId, string memory eventType) private {
        History memory newHistroy = History({
            eventType: eventType,
            timestamp: block.timestamp,
            userId: userId,
            userAddress : msg.sender

        });

        logs.push(newHistroy);
        userToHistroy[userId].push(newHistroy);
    }

    // 내 유언 조회
    function MyWill() public view returns (Will memory) {
        require(
            bytes(addressToWill[msg.sender].userId).length != 0,
            "no Wills"
        );
        return addressToWill[msg.sender];
    }
    
    // 내 유언 이력 조회
    function MyWillLogs(
        string memory _userId
    ) public view returns (History[] memory) {
        require((userToHistroy[_userId]).length > 0, "no records");
        return userToHistroy[_userId];
    }

    // 열람인 유언 조회
    function ViewWillLogs(
        string memory _userId
    ) public view returns (Will memory) {
        // 유저 아이디로 주소를 찾는다.
        address _address = userIdToaddress[_userId];
        // 주소로 유언을 찾는다.
        Will memory _will = addressToWill[_address];
        // 유언을 반환한다.
        return _will;
    }
    // 해시를 통한 유언 조회

    function SearchByHash(
        string memory _fileHash,
        string memory _userId
    ) public view returns (uint) {
        // require(bytes(hashToWill[_fileHash].userId).length != 0, "no wills.");
        require((userIdToWills[_userId]).length != 0, "no wills");
        // viewWillLog를 통해 아이디로 유언의 해시를 받고
        // 그 해시와 입력된 해시를 비교하여 유언의 유효성을 조회한다.
        string memory originalHash = ViewWillLogs(_userId).fileHash;
        if (
            keccak256(abi.encodePacked(originalHash)) ==
            keccak256(abi.encodePacked(_fileHash))
        ) {
            return 200;
        } else {
            return 403;
        }
        // return ;
        //
        // return hashToWill[_fileHash];
    }

    // 로그 조회
    function getLogs() public view returns (History[] memory) {
        return logs;
    }


    modifier onlyWriter(string memory _userId) {
        require(
            keccak256(abi.encodePacked(addressToUserId[msg.sender])) ==
                keccak256(abi.encodePacked(_userId)),
            "Caller is not owner"
        );
        _;
    }
    // 유언 삭제
    function DeleteWill(string memory _userId) public onlyWriter(_userId) returns(uint) {
        // onlyWriter를 통해 유저가 유언을 삭제할 권한이 있는지 확인했다. 따라서 msg.sender는 유저의 주소이다..
        string memory _hash = addressToWill[msg.sender].fileHash;
        // 찾은 주소를 통해 유언을 찾는다.
        delete addressToWill[msg.sender]; // 주소 - 유언을 삭제한다.
        delete hashToWill[_hash]; // 주소 - 유언이 삭제되면 자연스럽게 해시 - 유언도 삭제된다.
        // 이력을 추가한다.
        logHistory(_userId, unicode"유언 삭제");
        
        if (bytes(addressToWill[msg.sender].userId).length == 0) {
            // 유언 삭제 성공 메시지를 반환한다.
            return 200;
        } else {
            // 유언 삭제 실패 메시지를 반환한다.
            return 403;
        }
    }
}
