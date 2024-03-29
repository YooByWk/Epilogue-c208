import React from "react";
import { useNavigate } from "react-router-dom";

function Select() {
    const Navi = useNavigate();
    
    return (
        <>
        <button onClick={(event) => Navi('/witness')}>증인의 고인 정보 입력</button>
        </>
    )
}

export default Select;