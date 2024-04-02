import React from 'react';
import { useLocation, useParams } from 'react-router-dom';
import BlockChainHashHook from './hooks/blockChainHash';

function Will() {
    const { userId } = useParams();
    const location = useLocation();
    const { s3url, willCode } = location.state;
    const  blockChainRes = BlockChainHashHook(willCode);
    console.log('blockChainRes: ', blockChainRes);
    // console.log(location.state);
    return(
        <div style={s1}>
        <div >유언장</div>
        <video src={s3url} alt="비디오" controls style={{width :'35%', height:'3vh'}}></video>
        <button style={cc.button} onClick={()=>{console.log('클릭')}}>블록체인 유언장 유효성 검사</button>
        </div>
        
    )
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