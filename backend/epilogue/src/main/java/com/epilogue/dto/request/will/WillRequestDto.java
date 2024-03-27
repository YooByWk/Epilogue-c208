package com.epilogue.dto.request.will;

import com.epilogue.domain.witness.Witness;
import com.epilogue.dto.request.viewer.ViewerRequestDto;
import com.epilogue.dto.request.witness.WitnessRequestDto;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@Schema(description = "유언 요청 DTO")
public class WillRequestDto {
    @Schema(description = "연명 치료 여부")
    private String sustainCare;

    @Schema(description = "희망 장례 방식")
    private String funeralType;

    @Schema(description = "희망 묘 방식")
    private String graveType;

    @Schema(description = "장기 기증 여부")
    private String organDonation;

    @NotNull(message = "유언 파일 주소는 Null일 수 없습니다.")
    @Schema(description = "유언 파일 주소")
    private String willFileAddress;

    @NotNull(message = "열람 신청 링크는 Null일 수 없습니다.")
    @Schema(description = "열람 신청 링크")
    private String viewApplyLink;

    @NotNull(message = "유언장 링크는 Null일 수 없습니다.")
    @Schema(description = "유언장 링크")
    private String willLink;
}
