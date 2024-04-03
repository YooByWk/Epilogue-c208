import { useState, useEffect } from 'react';
import Web3 from 'web3';
import WillSystemABI from '../smartContract/will_system.json';
import  axios from 'axios';


export default function IpfsHook (userId) {
  const IpfsURL = process.env.REACT_APP_IPFS_URL;
  const BaseURL = process.env.REACT_APP_API_URL;

  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [result, setResult] = useState([{}]);
  const [hash, setHash] = useState('');
  const [id, setId] = useState('');
  const [file, setFile] = useState(null);
  const [uploadImgUrl, setUploadImgUrl] = useState('');
  const [willCode, setWillCode] = useState('');
  

  useEffect(() => {
    async function init() {
      // web 3 생성
      const web3 = new Web3(new Web3.providers.HttpProvider(process.env.REACT_APP_RPC_URL));
      setWeb3(web3);
      // 스마트 컨트랙트 설정
      const contractAddress = process.env.REACT_APP_CONTRACT_ADDRESS;
      const contract = new web3.eth.Contract(WillSystemABI, contractAddress);
      setContract(contract);
    }
    init();
  },[]) // useEffect 
  
  // 목표 : 코드를 입력하면 블록체인에 저장된 값을 가져온다.

  // 유저아이디로 주소를 가져온다.
   
  // 주소를 통해 유언을 가져온다

  // 유언을 가져와서 ipfs에 저장된 파일을 가져온다.


} 