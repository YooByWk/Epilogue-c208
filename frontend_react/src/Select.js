import React from "react";
import { useNavigate } from "react-router-dom";

function Select() {
    const Navi = useNavigate();
    
    return (
        <div style={styles.container}>
            <button onClick={(event) => Navi('/witness')} style={styles.button}>증인의 고인 정보 입력</button>
            <button onClick={(event) => Navi('/viewer')} style={styles.button}>열람인의 유언장 확인</button>
        </div>
    )
}

const styles = {
    container: {
        maxWidth: '600px',
        margin: 'auto',
        textAlign: 'center',
        padding: '20px',
    },
    button: {
        display: 'block',
        width: '100%',
        padding: '15px 20px',
        marginBottom: '20px',
        borderRadius: '5px',
        border: 'none',
        background: '#E4DCCF',
        color: '#617C77',
        fontSize: '1rem',
        fontWeight: 'bold',
        cursor: 'pointer',
        transition: 'background 0.3s ease',
    },
};

export default Select;
