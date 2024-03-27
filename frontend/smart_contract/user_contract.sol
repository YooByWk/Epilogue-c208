// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract UserContract {
    mapping(address => string) public addressToUserId;
    
    function registerUserId(string memory _userId) public { // 호출하면 일단 이 유저 아이디로 주소를 등록한다.
        addressToUserId[msg.sender] = _userId;
    } // 호출 할 때 아이디 집어을 것

    function getUserId(address _address) public view returns (string memory) {
        return addressToUserId[_address]; // 주소를 통해 아이디를 알아냄
    }
}