import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

function WillViewViewer() {
    const Navi = useNavigate();
    const [code, setCode] = useState('');

  const handleSubmit = async () => {
    // if (code.trim() === '') {
    //   alert('코드를 입력해주세요.');
    //   return;
    // }
    Navi('/will')
    // try {
    // //   const response = await axios.post('URL_HERE', { code });

    //   // Handle response as needed
    // } catch (error) {
    //   console.error('Error:', error);
    // }
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
      <button onClick={handleSubmit}>제출하기</button>
    </div>
  );
}

export default WillViewViewer;
