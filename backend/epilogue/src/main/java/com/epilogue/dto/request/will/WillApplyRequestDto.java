package com.epilogue.dto.request.will;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "유언 열람 인증 요청 DTO")
public class WillApplyRequestDto {
    @Schema(description = "고인 이름")
    private String deadName;

    @Schema(description = "고인 생년월일")
    private String deadBirth;

    @Schema(description = "증인 이름")
    private String witnessName;

    @Schema(description = "증인 코드")
    private String witnessCode;
}
