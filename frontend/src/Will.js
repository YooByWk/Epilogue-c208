import React from 'react';
import { useLocation, useParams } from 'react-router-dom';
import BlockChainHashHook from './hooks/blockChainHash';

function Will() {
    const { userId } = useParams();
    const location = useLocation();
    const { s3url } = location.state;
    const  blockChainRes = BlockChainHashHook();
    console.log('여기여기',blockChainRes);

    return(
        <>
        <div>유언장</div>
        <video src={s3url} alt="비디오" controls></video>
        </>
        
    )
}

export default Will;

const cc = {
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    border: '1px solid black',
    margin: '10px',
    padding: '10px'
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