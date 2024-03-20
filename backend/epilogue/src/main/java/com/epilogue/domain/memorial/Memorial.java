package com.epilogue.domain.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

import java.sql.Timestamp;
import java.util.UUID;

@Entity
@Getter
@Schema(description = "디지털 추모관")
public class Memorial {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "디지털 추모관 식별키")
    private int memorialSeq;

    @NotNull
    @Schema(description = "회원 식별키")
    private UUID userSeq;

    @NotNull
    @Schema(description = "별세 일자")
    private Timestamp goneDate;

    @NotNull
    @Schema(description = "묘비명")
    private String graveName;

    @NotNull
    @Schema(description = "묘비 사진")
    private String graveImg;
}
