// blockCahin.js
import { useState, useEffect } from 'react';
import Web3 from 'web3';
import WillSystemABI from '../smartContract/will_system.json';
import  axios from 'axios';



export default function BlockChainHashHook () {
  const BaseURL = process.env.REACT_APP_API_URL;
  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [result, setResult] = useState([{}]);
  

  useEffect(() => {
  async function init() {
    // web 3 생성
    const web3 = new Web3(new Web3.providers.HttpProvider(process.env.REACT_APP_RPC_URL));
    setWeb3(web3);
    // 스마트 컨트랙트 설정
    const contractAddress = process.env.REACT_APP_CONTRACT_ADDRESS;
    const contract = new web3.eth.Contract(WillSystemABI, contractAddress);
    setContract(contract);

    
    ////// S3 버킷에 올라간 파일을 가져오는 코드
    // 0. 임시 공간에 저장 
    // console.log(BaseURL + 'api/will/certificate/');
    const willCode = 'e3a03883-8685-488f-b620-ac641e3c1432';
    let formData = new FormData();
    formData.append('willCode', willCode);
    console.log(formData)
    axios.post(`${BaseURL}/api/will/certificate/`, formData)
    .then((res) => {console.log('호출결과'  ,res)})
    .catch((e) => {console.log(e)});
    
    // 1. 다운받는다

    // 2. 해시값을 구한다


    // try {
    //   // 함수 호출
    //   const res = await contract.methods.getLogs().call().then((r) => {
    //     setResult(r);


    //      console.log('여기까지 오나?');
    //     console.log('성공', r);
    //   }).catch((e) => {console.log(e)});
    //   // console.log(res);
    // } catch (e) {
    //   // 에러처리 : 윗부분이 안된 경우에.
    //   console.log(e);
    // }
    



  } // init() 함수 끝

  init(); // 비동기 함수 호출
}, []);
  return result
} 