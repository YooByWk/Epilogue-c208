// Will.js
import React from "react";
import { useLocation } from "react-router-dom";
import willPlayImage from "./willplayimage.jpg";

function Will() {
  const location = useLocation();
  const { s3url } = location.state;

  return (
    <>
      <div style={styles.container}>
        <h1>유언장</h1>
        <h3>삼가 고인의 명복을 빕니다.</h3>
        <video
          src={s3url}
          alt="비디오"
          controls
          style={styles.video}
          poster={willPlayImage}
        />
        <button style={styles.button}>진위 여부 확인하기</button>
      </div>
    </>
  );
}

export default Will;

const styles = {
  container: {
    maxWidth: "600px",
    margin: "auto",
    textAlign: "center",
    padding: "20px",
  },
  title: {
    fontSize: "2rem",
    marginBottom: "20px",
    color: "#617C77",
  },
  subtitle: {
    fontSize: "1.2rem",
    marginBottom: "20px",
    color: "#99A799",
  },
  input: {
    width: "100%",
    padding: "10px",
    marginBottom: "20px",
    borderRadius: "5px",
    border: "1px solid #ADC2A9",
    boxSizing: "border-box",
  },
  button: {
    padding: "10px 20px",
    background: "#E4DCCF",
    color: "#000000",
    border: "none",
    borderRadius: "5px",
    cursor: "pointer",
    fontSize: "1rem",
    transition: "background 0.3s ease",
    marginTop: "30px",
  },
  video: {
    width: "100%",
    height: "auto",
    maxWidth: "560px",
    maxHeight: "315px",
  },
};