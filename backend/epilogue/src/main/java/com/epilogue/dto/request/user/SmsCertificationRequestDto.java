package com.epilogue.dto.request.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "인증번호 요청 DTO")
public class SmsCertificationRequestDto {

    @Schema(description = "인증 받을 휴대번호")
    private String phone;

    @Schema(description = "인증번호")
    private String certificationNumber;

}
