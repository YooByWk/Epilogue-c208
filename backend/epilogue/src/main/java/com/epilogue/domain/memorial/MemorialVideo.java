package com.epilogue.domain.memorial;

import com.epilogue.domain.user.User;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Entity
@Getter
@Builder
@RequiredArgsConstructor
@AllArgsConstructor
public class MemorialVideo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "추모관 동영상 식별키")
    private int memorialVideoSeq;

    @NotNull
    @Schema(description = "기존 동영상 url")
    private String originalVideoUrl;

    @NotNull
    @Schema(description = "유니크한 동영상 url")
    private String uniqueVideoUrl;

    @NotNull
    @Schema(description = "디지털 추모관 식별키")
    @ManyToOne
    private Memorial memorial;

    @NotNull
    @Schema(description = "업로드한 회원 식별키")
    @ManyToOne
    private User user;

    @Schema(description = "설명 내용")
    private String content;
}
