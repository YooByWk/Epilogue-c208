package com.epilogue.domain.will;


import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Entity
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "유언")
public class Will {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "유언 식별키")
    private int willSeq;

    @Schema(description = "연명 치료 여부")
    private boolean sustainCare;

    @Schema(description = "희망 장례 방식")
    private String funeralType;

    @Schema(description = "희망 묘 방식")
    private String graveType;

    @Schema(description = "장기 기증 여부")
    private boolean organDonation;

    @NotNull(message = "디지털 추모관 사용 여부는 Null일 수 없습니다.")
    @Schema(description = "디지털 추모관 사용 여부")
    private boolean useMemorial;

    @Schema(description = "묘비명")
    private String graveName;

    @Schema(description = "묘비 사진")
    private String graveImage;

    @NotNull(message = "유언 파일 이름은 Null일 수 없습니다.")
    @Schema(description = "유언 파일 이름")
    private String willFileName;

    @NotNull(message = "열람 신청 링크는 Null일 수 없습니다.")
    @Schema(description = "열람 신청 링크")
    private String viewApplyLink;

    @NotNull(message = "유언장 링크는 Null일 수 없습니다.")
    @Schema(description = "유언장 링크")
    private String willLink;
}
