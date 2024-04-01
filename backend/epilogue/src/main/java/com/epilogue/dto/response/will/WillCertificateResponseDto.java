package com.epilogue.dto.response.will;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class WillCertificateResponseDto {
    @NotNull
    @Schema(description = "유언 파일 주소")
    private String willFileAddress;

    @NotNull
    @Schema(description = "회원 아이디")
    private String userId;
}
