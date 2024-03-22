package com.epilogue.domain.memorial;

import com.epilogue.domain.user.User;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Getter;

import java.sql.Timestamp;

@Entity
@Getter
public class MemorialLetter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "디지털 추모관 편지 식별키")
    private String memorialLetterSeq;

    @Schema(description = "작성자 닉네임")
    private String nickname;

    @Schema(description = "편지 내용")
    private String content;

    @Schema(description = "작성일")
    private Timestamp date;

    @Schema(description = "고인 식별키")
    private int userSeq;

}
