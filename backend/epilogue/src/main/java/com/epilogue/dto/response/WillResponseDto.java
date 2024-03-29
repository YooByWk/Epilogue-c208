package com.epilogue.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
@Schema(description = "유언 응답 DTO")
public class WillResponseDto {
    @Schema(description = "연명 치료 여부")
    private String sustainCare;

    @Schema(description = "희망 장례 방식")
    private String funeralType;

    @Schema(description = "희망 묘 방식")
    private String graveType;

    @Schema(description = "장기 기증 여부")
    private String organDonation;

    @Schema(description = "디지털 추모관 사용 여부")
    private String useMemorial;

    @Schema(description = "묘비명")
    private String graveName;

    @Schema(description = "묘비 사진 주소")
    private String graveImageAddress;

    @Schema(description = "유언 파일 주소")
    private String willFileAddress;
}
