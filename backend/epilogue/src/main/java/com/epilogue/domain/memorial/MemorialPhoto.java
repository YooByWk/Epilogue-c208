package com.epilogue.domain.memorial;

import com.epilogue.domain.user.User;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Entity
@Getter
@Builder
@RequiredArgsConstructor
@AllArgsConstructor
public class MemorialPhoto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "추모관 사진 식별키")
    private int memorialPhotoSeq;

    @NotNull
    @Schema(description = "기존 사진 url")
    private String originalPhotoUrl;

    @NotNull
    @Schema(description = "유니크한 사진 url")
    private String uniquePhotoUrl;

    @NotNull
    @ManyToOne
    @Schema(description = "디지털 추모관 식별키")
    private Memorial memorial;

    @NotNull
    @ManyToOne
    @Schema(description = "업로드한 회원 식별키")
    private User user;

    @Schema(description = "설명 내용")
    private String content;
}
