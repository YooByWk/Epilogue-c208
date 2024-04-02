import React from 'react';
import { useLocation, useParams } from 'react-router-dom';

function Will() {
    const { userId } = useParams();
    const location = useLocation();
    const { s3url } = location.state;

    return(
        <>
        <div>유언장</div>
        <video src={s3url} alt="비디오" controls></video>
        </>
    )
}

export default Will;