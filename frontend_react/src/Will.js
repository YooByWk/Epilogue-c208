import React, { useEffect, useState } from 'react';
import { useLocation, useParams } from 'react-router-dom';
import BlockChainHashHook from './hooks/blockChainHash';
import ReactModal from 'react-modal';
import willPlayImage from "./willplayimage.jpg";
import axios from 'axios';
import CryptoJS from 'crypto-js';

function Will() {

  const location = useLocation();
  const { userId } = useParams();
  const { s3url, willCode, res } = location.state;
  const blockChainRes = BlockChainHashHook(willCode);
  const [isModalOpen, setIsModalOpen] = React.useState(false);
  const [message, setMessage] = React.useState('');
  const [isValid, setIsValid] = React.useState(true);

  // console.log(res);
  const handleClick = () => {
    setIsModalOpen(true);
    if (blockChainRes) {
      setMessage("유언 기록 당시 업로드된 원본입니다.");
    } else {
      setMessage("위변조된 원본입니다.");
    }
  };
  const [hash, setHash] = useState('');

  const downloadAndHashFile = async (url) => {
    const response = await axios.get(url, { responseType: 'arraybuffer' });
    const wordArray = CryptoJS.lib.WordArray.create(response.data);
    const hash = CryptoJS.SHA256(wordArray).toString();
    setHash(hash.toUpperCase());
    // console.log(hash == res['fileHash'] ? '유언장의 해시값이 일치합니다.' : '유언장의 해시값이 일치하지 않습니다.');
    setIsValid((hash) === res['fileHash']);
  };
  
  useEffect(() => {
    downloadAndHashFile(process.env.REACT_APP_IPFS_URL + res['3']);
  }, []);
  // downloadAndHashFile(process.env.REACT_APP_IPFS_URL + res['3']);
  const modalStyle = {

    content: {
      top: '50%',
      left: '50%',
      right: 'auto',
      bottom: 'auto',
      marginRight: '-50%',
      transform: 'translate(-50%, -50%)',
      backgroundColor: '#f8f9fa',
      borderRadius: '0.3rem',
      padding: '2rem',
      border: 'none',
      boxShadow: '0 0.5rem 1rem rgba(0, 0, 0, 0.15)',
      maxWidth: '300px',
      width: '50%',
      fontFamily: '"Helvetica Neue", Helvetica, Arial, sans-serif',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',

    },
    overlay: {
      backgroundColor: 'rgba(0, 0, 0, 0.5)'
    },
    button: {
      padding: '0.5rem 1rem',
      color: '#fff',
      backgroundColor: '#E4DCCF',
      border: '1px solid #E4DCCF',
      borderRadius: '0.3rem',
      fontSize: '1rem',
      lineHeight: '1.5',
      transition: 'color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out',
      fontFamily: '"Helvetica Neue", Helvetica, Arial, sans-serif',
      cursor: 'pointer',
      width: '75%',
    }
  };
  // useEffect(() => {});
  return (
    <>
      <div style={styles.container}>
        <h1>유언장</h1>
        <h3>삼가 고인의 명복을 빕니다.</h3>
        {/* <video
        src={s3url}
        alt="비디오"
        controls
        style={styles.video}
        poster={willPlayImage}
        /> */}
        <video src= {process.env.REACT_APP_IPFS_URL+ res['3']} alt={'블록체인 비디오'} controls style={styles.video} poster={willPlayImage}  />
        {isValid ? <h3 style={validate}>유언장의 위변조가 감지되지 않았습니다.</h3> : <h3 style={invalidate}>유언장의 해시값이 일치하지 않습니다.</h3>}
        {/* <button style={styles.button } onClick={handleClick}>진위 여부 확인하기</button> */}
        <ReactModal isOpen={isModalOpen} style= {modalStyle}>
          <p>{message}</p>
          <button style={modalStyle.button} onClick={() => setIsModalOpen(false)}> 닫기 </button>
          {/* <button onClick={downloadAndHashFile}> 다운로드 </button> */}
        </ReactModal>
    </div>
    </>
  );
}

export default Will;

const validate = {
  // padding: '0.5rem 1rem',
  height: '2.5rem',
  color: '#000',
  backgroundColor: '#4CAF50',
  border: '1px solid #E4DCCF',
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  justifyContent: 'center',
  borderRadius: '0.3rem',
  fontSize: '1rem',
  lineHeight: '1.5',
  transition: 'color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out',
  fontFamily: '"Helvetica Neue", Helvetica, Arial, sans-serif',
  // cursor: 'pointer',
  width: '75%',
}
const invalidate = {
  height: '2.5rem',
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  justifyContent: 'center',
  color: '#000',
  backgroundColor: '#f44336',
  border: '1px solid #E4DCCF',
  borderRadius: '0.3rem',
  fontSize: '1rem',
  lineHeight: '1.5',
  transition: 'color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out',
  fontFamily: '"Helvetica Neue", Helvetica, Arial, sans-serif',
  // cursor: 'pointer',
  width: '75%',
};
const styles = {
  container: {
    maxWidth: "600px",
    margin: "auto",
    textAlign: "center",
    padding: "20px",
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
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
    marginTop: "30px",
  },
  video: {
    width: "100%",
    height: "auto",
    maxWidth: "560px",
    maxHeight: "315px",
  },
};