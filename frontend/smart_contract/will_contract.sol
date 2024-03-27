// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import './user_contract.sol';

contract WillContract {
    UserContract userContract;
    mapping(string => string[]) public userIdToWills;
    mapping(address => string) public addressToUserId;
    
    constructor(address _userContractAddress) {
        userContract = UserContract(_userContractAddress);
    }

    modifier onlyOwner(string memory _userId) {
        string memory registeredUserId = userContract.getUserId(msg.sender);
        require(keccak256(abi.encodePacked(registeredUserId)) == keccak256(abi.encodePacked(_userId)) || bytes(registeredUserId).length == 0, "Caller is not owner");
        _;
    }

    function createWill(string memory _userId, string memory _willHash) public (_userId) {
      
    }
    
}