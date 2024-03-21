package com.epilogue.dto.request.witness;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "증인 요청 DTO")
public class WitnessRequestDto {
    @NotNull(message = "증인 이름은 Null일 수 없습니다.")
    @Schema(description = "증인 이름")
    private String witnessName;

    @NotNull(message = "증인 이메일은 Null일 수 없습니다.")
    @Schema(description = "증인 이메일")
    private String witnessEmail;

    @NotNull(message = "증인 휴대폰 번호는 Null일 수 없습니다.")
    @Schema(description = "증인 휴대폰 번호")
    private String witnessMobile;
}
