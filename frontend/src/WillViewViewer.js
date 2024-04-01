import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Will from './Will';

function WillViewViewer() {
  const Navi = useNavigate();
    const [code, setCode] = useState('');

    const baseUrl = 'http://j10c208.p.ssafy.io';

  const applyViewer = async () => {
    if (code.trim() === '') {
      alert('코드를 입력해주세요.');
      return;
    } 
    console.log('누름요')
    try {
      const response = await axios.post(`${baseUrl}/api/will/certificate`, { code });

      if (response.status === 200) {
        console.log('열람 성공:', response.data);
        Navi('/will')
        // <Route exact path="/will" videoPath={'메롱'} />
      } else {
        console.log('열람 오류:', response.status);
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
    <div>
      <h1>유언장 확인하기</h1>
      <p>유언장을 확인하기 위해 전달 받은 코드를 입력해주세요.</p>
      <input
        type="text"
        placeholder="보안코드"
        value={code}
        onChange={(e) => setCode(e.target.value)}
      />
      <button onClick={applyViewer}>제출하기</button>
    </div>
  );
}

export default WillViewViewer;
