import { useState, useEffect } from "react";
import WillSystemABI from '../smartContract/will_system.json';
import Web3 from 'web3';
import axios from 'axios';

/**
 * 
 * @param {*} funcName 
 * @param {*} args : 리스트 형태로 넣어준다.
 */
const UseBlockCall = (funcName, args) => {
  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [result, setResult] = useState([{}]);

  useEffect(() => {
    async function init() {
      var backRes;
      // web 3 생성
      const web3 = new Web3(
        new Web3.providers.HttpProvider(process.env.REACT_APP_RPC_URL)
      );
      setWeb3(web3);
      // 스마트 컨트랙트 설정
      const contractAddress = process.env.REACT_APP_CONTRACT_ADDRESS;
      const contract = new web3.eth.Contract(WillSystemABI, contractAddress);
      setContract(contract);

      var res = await contract.methods[funcName](...args).call().then((r) => {
        backRes = r;
        console.log("성공rr", r.toString());
      }).catch((e) => {
        console.log(e);
      });
      
      
    }
    init();
  });
};

export default UseBlockCall;
