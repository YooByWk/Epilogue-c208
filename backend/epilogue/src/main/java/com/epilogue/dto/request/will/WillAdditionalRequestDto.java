package com.epilogue.dto.request.will;

import com.epilogue.domain.will.Will;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "추가 정보 요청 DTO")
public class WillAdditionalRequestDto {
    @NotNull(message = "연명 치료 여부는 Null일 수 없습니다.")
    @Schema(description = "연명 치료 여부")
    private Will.SustainCare sustainCare;

    @NotNull(message = "희망 장례 방식은 Null일 수 없습니다.")
    @Schema(description = "희망 장례 방식")
    private String funeralType;

    @NotNull(message = "희망 묘 방식은 Null일 수 없습니다.")
    @Schema(description = "희망 묘 방식")
    private String graveType;

    @NotNull(message = "장기 기증 여부는 Null일 수 없습니다.")
    @Schema(description = "장기 기증 여부")
    private Will.OrganDonation organDonation;
}
