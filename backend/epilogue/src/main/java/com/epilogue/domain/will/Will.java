package com.epilogue.domain.will;


import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "유언")
public class Will {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull
    @Schema(description = "유언 식별키")
    private int willSeq;

    @NotNull
    @Schema(description = "회원 식별키")
    private int userSeq;

    @Schema(description = "연명 치료 여부")
    private boolean sustainCare;

    @Schema(description = "희망 장례 방식")
    private String funeralType;

    @Schema(description = "희망 묘 방식")
    private String graveType;

    @Schema(description = "장기 기증 여부")
    private boolean organDonation;

    @NotNull
    @Schema(description = "디지털 추모관 사용 여부")
    private boolean useMemorial;

    @Schema(description = "묘비명")
    private String graveName;

    @Schema(description = "묘비 사진")
    private String graveImage;

    @Schema(description = "유언 읽기용 스크립트")
    private String willDraftScript;

    @Schema(description = "유언 최종 스크립트")
    private String willFinalScript;

    @NotNull
    @Schema(description = "유언 파일 이름")
    private String willFileName;

    @NotNull
    @Schema(description = "증인 이름")
    private String witnessName;

    @Schema(description = "증인 이메일")
    private String witnessEmail;

    @Schema(description = "증인 전화번호")
    private String witnessPhone;

    @NotNull
    @Schema(description = "증인 코드")
    private UUID witnessCode;

    @NotNull
    @Schema(description = "열람 신청 링크")
    private String viewApplyLink;

    @NotNull
    @Schema(description = "유언장 링크")
    private String willLink;
}
