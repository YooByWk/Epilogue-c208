package com.epilogue.dto.request.viewer;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "열람인 요청 DTO")
public class ViewerRequestDto {
    @NotNull(message = "열람인 이름은 Null일 수 없습니다.")
    @Schema(description = "열람인 이름")
    private String viewerName;

    @Schema(description = "열람인 이메일")
    private String viewerEmail;

    @Schema(description = "열람인 휴대폰 번호")
    private String viewerMobile;
}
