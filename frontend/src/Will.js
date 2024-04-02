import React from 'react';
import { useLocation, useParams } from 'react-router-dom';
import BlockChainHashHook from './hooks/blockChainHash';
import ReactModal from 'react-modal';

function Will() {
  const { userId } = useParams();
  const location = useLocation();
  const { s3url, willCode } = location.state;
  const blockChainRes = BlockChainHashHook(willCode);
  const [isModalOpen, setIsModalOpen] = React.useState(false);
  const [message, setMessage] = React.useState('');

  const handleClick = () => {
    setIsModalOpen(true);
    if (blockChainRes) {
      setMessage("유언 기록 당시 업로드된 원본입니다.");
    } else {
      setMessage("위변조된 원본입니다.");
    }
  };

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

  return (
    <div style={s1}>
      <div>유언장</div>
      <video src={s3url} alt="비디오" controls style={{width :'35%', height:'3vh'}}></video>
      <button style={cc.button} onClick={handleClick}>블록체인 유언장 유효성 검사</button>
      <ReactModal isOpen={isModalOpen} style={modalStyle}>
        <p>{message}</p>
        <button style={modalStyle.button} onClick={() => setIsModalOpen(false)}>닫기</button>
      </ReactModal>
    </div>
  );
}

export default Will;

const s1 = {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
}

const cc = {
    video: {
        width: '50%',
        height: '0',
        marginBottom: '20px',
    },
    button: {
        marginTop: '2vh',
        padding: '10px 20px',
        background: '#E4DCCF',
        color: '#000000',
        border: 'none',
        borderRadius: '5px',
        cursor: 'pointer',
        fontSize: '1rem',
        transition: 'background 0.3s ease',
        width : '35%',
      },
}

/* 
import BlockChainHashHook from './hooks/blockChainHash';


function Will()  {
    const blockChainRes = BlockChainHashHook();
    // console.log('여기여기',blockChainRes);
    // await blockChainRes.init();
    return(
        <>
        <h1>유언장</h1>
            <video src="7d3a2056-371b-4329-8fa8-815caee56054.mp4" alt="비디오"></video>
            
            <div>
            {blockChainRes.map((i)=> {
                const date = new Date(Number(i.timestamp) * 1000);
                return <div style={cc}>
                    <p>유저 아이디 : {i.userId}</p>
                    <p>이벤트 로그 : {i.eventType}</p>
                    <p>생성일자 : {date.toLocaleString()}</p>
                </div>
            })}
                <h2>유언장 내용</h2>
                <p>유언장 내용이 들어가는 곳</p>
            </div>
*/