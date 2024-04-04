// blockCahin.js
import { useState, useEffect } from 'react';
import Web3 from 'web3';
import WillSystemABI from '../smartContract/will_system.json';
import  axios from 'axios';

  /**
   *  여기서는 블록체인에 해시값을 호출하는 코드를 작성한다.
   */
export default function BlockChainHashHook (willCode) {

  const BaseURL = process.env.REACT_APP_API_URL;
  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [result, setResult] = useState([{}]);
  

  useEffect(() => {
  async function init() {
    var backRes
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
    // const willCode = 'e3a03883-8685-488f-b620-ac641e3c1432';

    // 1. 다운받는다 - cors 뜰것같음 Pass

    // 2. 해시값을 구한다
    
    let formData = new FormData();
    formData.append('willCode', willCode);
    
    await axios.post(`${BaseURL}/api/will/certificate`, formData)
    .then((res) => {backRes = {'hash' : res.data['hashCode'], 'id' : res.data['userId']}; console.log(res.data);})
    .catch((e) => {console.log(e)});
    
    var params = [backRes['hash'], backRes['id']];
    // 해시값을 소문자로 바꾼다
    params[0] = params[0].toLowerCase();
    console.log(params);
    try {
      // 함수 호출
      // const hash = await contract.methods.addressToWill('0x080D12635a2204dA298c1B8eF5653c70718ac058').call() 
      
      var k;

      var res = await contract.methods.SearchByHash(params[0], params[1]).call().then((r) => {
        k = r.toString();
        // setResult(r.toString());
        console.log('성공rr', r.toString());
      }).catch((e) => {console.log(e)});
      // console.log(res);
    } catch (e) {console.log(e);}

     k === '200'? setResult(true) : setResult(false);
    return 


  } // init() 함수 끝

  init(); // 비동기 함수 호출
}, []);
  return result
} 