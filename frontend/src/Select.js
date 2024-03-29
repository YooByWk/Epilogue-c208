import React from "react";
import { useNavigate } from "react-router-dom";

function Select() {
    const Navi = useNavigate();
    
    return (
        <>
        <button onClick={(event) => Navi('/witness')}>증인의 고인 정보 입력</button>
        <button onClick={(event) => Navi('/viewer')}>열람인의 유언장 확인</button>
        </>
    )
}

export default Select;