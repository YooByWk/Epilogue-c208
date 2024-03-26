package com.epilogue.dto.request.will;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "디지털 추모관 정보 요청 DTO")
public class WillMemorialRequestDto {
    @NotNull(message = "디지털 추모관 사용 여부는 Null일 수 없습니다.")
    @Schema(description = "디지털 추모관 사용 여부")
    private boolean useMemorial;

    @Schema(description = "묘비명")
    private String graveName;
}
