package com.epilogue.dto.request.will;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "유언 작성 DTO")
public class WillRequestDto {
    @Schema(description = "연명 치료 여부")
    private boolean sustainCare;

    @Schema(description = "희망 장례 방식")
    private String funeralType;

    @Schema(description = "희망 묘 방식")
    private String graveType;

    @Schema(description = "장기 기증 여부")
    private boolean organDonation;

    @Schema(description = "디지털 추모관 사용 여부")
    private boolean useMemorial;

    @Schema(description = "묘비명")
    private String graveName;

    @Schema(description = "묘비 사진")
    private String graveImage;

    @Schema(description = "유언 초안 스크립트")
    private String willDraftScript;

    @Schema(description = "유언 파일 이름")
    private String willFileName;

    @Schema(description = "열람 신청 링크")
    private String viewApplyLink;

    @Schema(description = "유언장 링크")
    private String willLink;
}
