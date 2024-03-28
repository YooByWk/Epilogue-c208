package com.epilogue.domain.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.sql.Timestamp;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemorialLetter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "디지털 추모관 편지 식별키")
    private int memorialLetterSeq;

    @Schema(description = "작성자 닉네임")
    private String nickname;

    @NotNull
    @Schema(description = "편지 내용")
    private String content;

    @NotNull
    @Schema(description = "작성일")
    private Timestamp writtenDate;

    @ManyToOne
    @Schema(description = "디지털 추모관 식별키")
    private Memorial memorial;

}
