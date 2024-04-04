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