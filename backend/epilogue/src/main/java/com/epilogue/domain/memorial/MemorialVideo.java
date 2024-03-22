package com.epilogue.domain.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;

@Entity
@Getter
public class MemorialVideo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "동영상 식별키")
    private String videoSeq;

    @Schema(description = "동영상 객체 url")
    private String videoURL;

    @Schema(description = "고인 식별키")
    private int userSeq;
}
