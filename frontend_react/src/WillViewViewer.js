import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Will from './Will';
import IpfsHook from './hooks/ipfsHook';
import Web3 from 'web3';
import WillSystemABI from './smartContract/will_system.json';

function WillViewViewer() {
  const Navi = useNavigate();
  const [code, setCode] = useState('');
  const baseUrl = 'http://j10c208.p.ssafy.io:8080';
  const applyViewer = async () => {
    if (code.trim() === '') {
      alert('코드를 입력해주세요.');
      return;
    }
  
    const formData = new FormData();
    formData.append('willCode', code);
  
    try {
      const response = await axios.post(`${baseUrl}/api/will/certificate`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });
  
      if (response.status === 200) {
        // console.log('열람 성공:', response.data);
        const userId = response.data.userId
        const s3url = response.data.willFileAddress

        const web3 = new Web3(new Web3.providers.HttpProvider(process.env.REACT_APP_RPC_URL));
        const contractAddress = process.env.REACT_APP_CONTRACT_ADDRESS;
        const contract = new web3.eth.Contract(WillSystemABI, contractAddress);
        var k;
        await contract.methods.userIdToaddress(userId).call().then((r)=>{k =r ; }).catch((e)=>{console.log(e)});
        // var address = await res['1']
        var res = await contract.methods.addressToWill(k).call();
        // console.log('asd',res)
        Navi(`/will/${userId}`, {state : {s3url : s3url, 'willCode' : code, 'res': res} });
        // console.log('열람 성공 : ', response.data.willFileAddress)
        // return;
      } if (response.status === 204) {
        alert('유언장 코드를 확인해주세요.')
        // return;
      } 
      else {
        console.log('열람 :', response.status);
      } 
    } catch (error) {
      console.error('Error:', error);
    }
  };
  

  return (
    <div style={styles.container}>
      <h1 style={styles.title}>유언장 확인하기</h1>
      <p style={styles.subtitle}>
        유언장을 확인하기 위해 전달 받은 코드를 입력해주세요.
      </p>
      <input
        type="text"
        placeholder="보안코드"
        value={code}
        onChange={(e) => setCode(e.target.value)}
        style={styles.input}
      />
      <button onClick={applyViewer} style={styles.button}>
        제출하기
      </button>
    </div>
  );
}

const styles = {
  container: {
    maxWidth: "600px",
    margin: "auto",
    textAlign: "center",
    padding: "20px",
  },
  title: {
    fontSize: "2rem",
    marginBottom: "20px",
    color: "#617C77",
  },
  subtitle: {
    fontSize: "1.2rem",
    marginBottom: "20px",
    color: "#99A799",
  },
  input: {
    width: "100%",
    padding: "10px",
    marginBottom: "20px",
    borderRadius: "5px",
    border: "1px solid #ADC2A9",
    boxSizing: "border-box",
  },
  button: {
    padding: "10px 20px",
    background: "#E4DCCF",
    color: "#000000",
    border: "none",
    borderRadius: "5px",
    cursor: "pointer",
    fontSize: "1rem",
    transition: "background 0.3s ease",
  },
};

export default WillViewViewer;
