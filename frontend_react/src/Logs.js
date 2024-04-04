import BlockChainLogHook from "./hooks/blockChainLog";

import styled from "styled-components";

function Logs() {
  const blockChainRes = BlockChainLogHook();
  var k = 0;
  // console.log('여기여기',blockChainRes);
  // await blockChainRes.init();
  return (
    <div style={container}>
      <h1 style={title}>유언장 로그</h1>

      <div>
        {blockChainRes.sort((a, b) => {
          const dateA = new Date(Number(a.timestamp) * 1000);
          const dateB = new Date(Number(b.timestamp) * 1000);
          return dateB - dateA;
        }).map((i) => {
          const date = new Date(Number(i.timestamp) * 1000);
          k++
          return (
            <LogCard>
              <LogItem style={{flexDirection: 'row', justifyContent: 'space-evenly'}}>
                 {k}
                <p style={{marginLeft:'10px', margin : '0'}}>
                    <UserIcon /> 유저 아이디 : {i.userId}
                </p>
                <p style={{marginLeft:'10px', margin : '0'}}>

                    <EventIcon /> 이벤트 로그 : {i.eventType}
                </p>
                <p style={{marginLeft:'10px', margin : '0'}}>

                    <DateIcon /> 생성일자 : {date.toLocaleString()}
                </p>
              </LogItem>
            </LogCard>
          );
        })}

      </div>
    </div>
  );
}
const UserIcon = () => (
  <svg
    width="20"
    height="20"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
  >
    <circle cx="12" cy="7" r="4"></circle>
    <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"></path>
  </svg>
);

const EventIcon = () => (
  <svg
    width="20"
    height="20"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
  >
    <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
    <path d="M16 2v4M8 2v4M3 10h18"></path>
  </svg>
);

const DateIcon = () => (
  <svg
    width="20"
    height="20"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
  >
    <circle cx="12" cy="12" r="10"></circle>
    <polyline points="12 6 12 12 16 14"></polyline>
  </svg>
);
const LogCard = styled.div`
  display: flex;
  flex-direction: column;
  border: 1px solid #ddd;
  margin: 10px 0;
  /* padding: 20px; */
  border-radius: 5px;
  height: 3rem;
  width: 115%;
  background-color: #fff;
  box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.05);
  transition: box-shadow 0.3s ease;
  &:hover {
    box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.15);
  }
`;

const LogItem = styled.p`
  display: flex;
  align-items: center;
  margin-bottom: 10px;
  padding: 10px, 10px, 0px, 0px;
  &:last-child {
    margin-bottom: 0;
  }
  & > svg {
    margin-right: 10px;
  }
`;
const container = {
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    margin: "0 auto",
    maxWidth: "800px",
    padding: "20px",
    fontFamily: "Arial, sans-serif",
    backgroundColor: "#f4f4f4",
    borderRadius: "5px",
    boxShadow: "0px 0px 10px 0px rgba(0,0,0,0.15)",
  };
  
  const logItem = {
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    border: "1px solid #ddd",
    margin: "10px 0",
    padding: "20px",
    borderRadius: "5px",
    backgroundColor: "#fff",
    boxShadow: "0px 0px 10px 0px rgba(0,0,0,0.05)",
  };
  
  const title = {
    color: "#333",
    fontSize: "2em",
    marginBottom: "20px",
  };
  

export default Logs;

const cc = {
  display: "flex",
  flexDirection: "column",
  justifyContent: "center",
  alignItems: "center",
  border: "1px solid black",
  margin: "10px",
  padding: "10px",
};

