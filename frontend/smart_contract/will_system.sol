// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract WillSystem {

    // 유언장 구조체
    struct Will {  
        string userId;
        string fileHash;
        uint createdAt;
    }

    // 이력 추적용 구조체 
    struct History {
        string eventType;
        uint256 timestamp;
        string userId;
    }

    History[] public logs;

    mapping(address => string) private addressToUserId; // 하나의 주소는 하나의 아이디
    mapping(address => Will) public addressToWill; // 하나의 주소는 하나의 유언장
    mapping(string => Will[]) public userIdToWills; // 하나의 유저 아이디는 여러개의 유언장
    mapping(string => Will) public hashToWill; // 하나의 해시값은 하나의 유언장
    mapping(string => History[]) public userToHistroy; // 한 유저는 여러 이력

    function createWill(string memory userId, string memory fileHash) public  {

        // 0. 유언장 정보 등록
        Will memory newWill = Will({
            userId : userId,
            fileHash : fileHash,
            createdAt : block.timestamp
        });
        
        // 1. 유저를 등록한다
        addressToUserId[msg.sender] = userId;
        // 2. 주소와 유언 매핑
        addressToWill[msg.sender] = newWill;
        // 3. 아이디와 유언 매핑
        userIdToWills[userId].push(newWill);
        // 4. 헤시와 유언 매핑
        hashToWill[fileHash] = (newWill);
        // 5. 기록을 추가한다.
        logHistory(userId, unicode"유언생성" );
        // 반환한다.
    }

    function logHistory(string memory userId, string memory eventType) private {

        History memory newHistroy = History({
            eventType : eventType,
            timestamp : block.timestamp,
            userId : userId
        });

        logs.push(newHistroy);
        userToHistroy[userId].push(newHistroy);
    } 
    
    // 내 유언 조회
    function MyWill() public view returns (Will memory) {
        return addressToWill[msg.sender];
    }
    // 내 유언 이력 조회

    // 열람인 유언 조회

    // 유언 유효성 조회
    
}