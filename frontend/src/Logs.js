
import BlockChainLogHook from './hooks/blockChainLog';


function Logs()  {
    const blockChainRes = BlockChainLogHook();
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
        </>
        
    )
}

export default Logs;

const cc = {
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    border: '1px solid black',
    margin: '10px',
    padding: '10px'
}