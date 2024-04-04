import React, { useState } from 'react';
import axios from 'axios';

function WillApplyWitness() {
  const [deadName, setDeadName] = useState('');
  const [deadBirth, setDeadBirth] = useState('');
  const [witnessName, setWitnessName] = useState('');
  const [willCode, setWillCode] = useState('');
  const [uploadImgUrl, setUploadImgUrl] = useState('');
  const [file, setFile] = useState(null);

  const baseUrl = 'http://j10c208.p.ssafy.io:8080';


  const applyWitness = async () => {
    try {
      const response = await axios.post(`${baseUrl}/api/will/apply`, {
        "deadName": deadName,
        "deadBirth": deadBirth,
        "witnessName": witnessName,
        "willCode": willCode
      }
      );
      
    if (response.status === 200) {
      if (response.data === true) {
        // console.log('신청 성공:', response.data);
        alert(
          "신청이 정상적으로 접수되었습니다. \n확인 후 3-5일 이내 열람자에게 유언장 열람 안내를 발송해드리겠습니다.")
      } if (response.data === false) {
        alert('없는 정보입니다. \n입력한 정보를 다시 확인해주세요.')
      }} else if (response.status === 204) {
        alert('증인 코드를 확인해주세요')
      }
    } catch (error) {
      // console.error(error);
    }
  };


  const onchangeImageUpload = (e) => {
    const uploadedFile = e.target.files[0];
    setFile(uploadedFile);
    const reader = new FileReader();
    reader.readAsDataURL(uploadedFile);
    reader.onloadend = () => {
      setUploadImgUrl(reader.result);
    }
  };

  return (
    <div style={styles.container}>
      <h1 style={styles.title}>유언 열람 신청하기</h1>
      <p style={styles.subtitle}>유언 열람 신청에 필요한 정보를 입력해주세요.</p>
      <input
        type="text"
        placeholder="고인 성함"
        value={deadName}
        onChange={(e) => setDeadName(e.target.value)}
        style={styles.input}
      />
      <input
        type="text"
        placeholder="고인 생년월일(YYYY.MM.DD)"
        value={deadBirth}
        onChange={(e) => setDeadBirth(e.target.value)}
        style={styles.input}
      />
      <input
        type="text"
        placeholder="증인 성함"
        value={witnessName}
        onChange={(e) => setWitnessName(e.target.value)}
        style={styles.input}
      />
      <input
        type="text"
        placeholder="증인 코드"
        value={willCode}
        onChange={(e) => setWillCode(e.target.value)}
        style={styles.input}
      />
      <input type="file" accept="image/*" onChange={onchangeImageUpload} style={styles.fileInput} />
      {uploadImgUrl && <img src={uploadImgUrl} alt="Uploaded" style={styles.image} />}
      <button onClick={applyWitness} style={styles.button}>신청하기</button>
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
  fileInput: {
    display: 'block',
    margin: '20px auto',
  },
  image: {
    maxWidth: '100%',
    height: 'auto',
    marginBottom: '20px',
  },
  button: {
    padding: '10px 20px',
    background: '#E4DCCF',
    // color: '#F0EBE3',
    border: 'none',
    borderRadius: '5px',
    cursor: 'pointer',
    fontSize: '1rem',
    transition: 'background 0.3s ease',
  },
};

export default WillApplyWitness;
