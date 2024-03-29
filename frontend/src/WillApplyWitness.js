import React, { useState } from 'react';
// import axios from 'axios';

function WillApplyWitness() {
  const [deadName, setDeadName] = useState('');
  const [deadBirth, setDeadBirth] = useState('');
  const [witnessName, setWitnessName] = useState('');
  const [witnessCode, setWitnessCode] = useState('');

//   const baseUrl = 'http://j10c208.p.ssafy.io';

//   const applyWitness = async () => {
//     try {
//       const response = await axios.post(`${baseUrl}/api/will/apply`, {
//         deadName,
//         deadBirth,
//         witnessName,
//         witnessCode,
//       });

//       if (response.status === 200) {
//         console.log('신청 성공:', response.data);
//       } else {
//         console.log('신청 오류:', response.status);
//       }
//     } catch (error) {
//       console.error(error);
//     }
//   };

  return (
    <div>
      <h1>유언 열람 신청하기</h1>
      <p>유언 열람 신청에 필요한 정보를 입력해주세요.</p>
      <input
        type="text"
        placeholder="고인 성함"
        value={deadName}
        onChange={(e) => setDeadName(e.target.value)}
      />
      <input
        type="text"
        placeholder="고인 생년월일"
        value={deadBirth}
        onChange={(e) => setDeadBirth(e.target.value)}
      />
      <input
        type="text"
        placeholder="증인 성함"
        value={witnessName}
        onChange={(e) => setWitnessName(e.target.value)}
      />
      <input
        type="text"
        placeholder="증인 코드"
        value={witnessCode}
        onChange={(e) => setWitnessCode(e.target.value)}
      />
      {/* <button onClick={applyWitness}>신청하기</button> */}
    </div>
  );
}

export default WillApplyWitness;
