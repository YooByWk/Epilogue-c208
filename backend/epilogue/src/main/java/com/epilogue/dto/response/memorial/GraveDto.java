package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class GraveDto {

    @Schema(description = "고인 이름")
    private String name;

    @Schema(description = "생년월일")
    private String birth;

    @Schema(description = "별세일자")
    private String goneDate;

    @Schema(description = "묘비명")
    private String graveName;

    @Schema(description = "묘비사진")
    private String graveImg;

}
