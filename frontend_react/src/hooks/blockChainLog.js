// blockCahin.js
import { useState, useEffect } from 'react';
import Web3 from 'web3';
import WillSystemABI from '../smartContract/will_system.json';



export default function BlockChainLogHook () {

  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [result, setResult] = useState([{}]);

  console.log(process.env.REACT_APP_API_URL);
  console.log(process.env.REACT_APP_RPC_URL);
  console.log(process.env.REACT_APP_CHAIN_ID);
  console.log('process.env.REACT_APP_CONTRACT_ADDRESS: ', process.env.REACT_APP_CONTRACT_ADDRESS);
  // console.log(WillSystemABI);

  useEffect(() => {
  async function init() {
    const web3 = new Web3(new Web3.providers.HttpProvider(process.env.REACT_APP_RPC_URL));
    setWeb3(web3);

    const contractAddress = process.env.REACT_APP_CONTRACT_ADDRESS;
    const contract = new web3.eth.Contract(WillSystemABI, contractAddress);
    setContract(contract);

    try {
      const res = await contract.methods.getLogs().call();
      setResult(res);
      console.log(res);
    } catch (e) {
      console.log(e);
    }
    



  } // init() 함수 끝

  init(); // 비동기 함수 호출
}, []);
  return result
} 