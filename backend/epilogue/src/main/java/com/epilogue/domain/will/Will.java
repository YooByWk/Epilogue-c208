package com.epilogue.domain.will;


import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.UUID;

@Slf4j
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

    @Schema(description = "묘비 사진")
    private String graveImageAddress;

    @Schema(description = "유언 파일 주소")
    private String willFileAddress;
    
    @Schema(description = "유언 코드")
    private String willCode;

    @Schema(description = "유언장 구분을 위한 url 코드")
    private UUID urlCode;

    public void updateMemorial(String useMemorial, String graveName) {
        this.useMemorial = useMemorial;
        this.graveName = graveName;
    }

    public void updateAdditionalInformation(String sustainCare, String funeralType, String graveType, String organDonation) {
        this.sustainCare = sustainCare;
        this.graveType = graveType;
        this.funeralType = funeralType;
        this.organDonation = organDonation;
    }

    public void updateGraveImageAddress(String graveImageAddress) {
        this.graveImageAddress = graveImageAddress;
    }

    public void updateWillFileAddress(String willFileAddress) {
        this.willFileAddress = willFileAddress;
    }

    public void updateWillCode(String willCode) {
        this.willCode = willCode;
    }

    public void updateWillUrlCode(UUID urlCode) {
        this.urlCode = urlCode;
    }
}

