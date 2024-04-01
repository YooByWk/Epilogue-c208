import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Will from './Will';

function WillViewViewer() {
  const Navi = useNavigate();
  const [code, setCode] = useState('');
  const baseUrl = 'http://j10c208.p.ssafy.io:8080';

  const applyViewer = async () => {
    if (code.trim() === '') {
      alert('코드를 입력해주세요.');
      return;
    }
    console.log('누름요');
    try {
      const response = await axios.post(`${baseUrl}/api/will/certificate`, { code });

      if (response.status === 200) {
        console.log('열람 성공:', response.data);
        Navi('/will');
        // <Route exact path="/will" videoPath={'메롱'} />
      } else {
        console.log('열람 오류:', response.status);
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
    <div style={styles.container}>
      <h1 style={styles.title}>유언장 확인하기</h1>
      <p style={styles.subtitle}>유언장을 확인하기 위해 전달 받은 코드를 입력해주세요.</p>
      <input
        type="text"
        placeholder="보안코드"
        value={code}
        onChange={(e) => setCode(e.target.value)}
        style={styles.input}
      />
      <button onClick={applyViewer} style={styles.button}>제출하기</button>
    </div>
  );
}

const styles = {
  container: {
    maxWidth: '600px',
    margin: 'auto',
    textAlign: 'center',
    padding: '20px',
  },
  title: {
    fontSize: '2rem',
    marginBottom: '20px',
    color: '#617C77',
  },
  subtitle: {
    fontSize: '1.2rem',
    marginBottom: '20px',
    color: '#99A799',
  },
  input: {
    width: '100%',
    padding: '10px',
    marginBottom: '20px',
    borderRadius: '5px',
    border: '1px solid #ADC2A9',
    boxSizing: 'border-box',
  },
  button: {
    padding: '10px 20px',
    background: '#E4DCCF',
    color: '#000000',
    border: 'none',
    borderRadius: '5px',
    cursor: 'pointer',
    fontSize: '1rem',
    transition: 'background 0.3s ease',
  },
};

export default WillViewViewer;
