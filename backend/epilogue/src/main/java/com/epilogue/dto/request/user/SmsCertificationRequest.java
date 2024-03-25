package com.epilogue.dto.request.user;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SmsCertificationRequest {

    private String phone;
    private String certificationNumber;

}
