package com.epilogue.dto.response.memorial;

import com.epilogue.domain.memorial.MemorialLetter;
import com.epilogue.domain.memorial.MemorialPhoto;
import com.epilogue.domain.memorial.MemorialVideo;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class GraveResponseDto {

    @NotNull
    @Schema(description = "묘비 식별키")
    private int graveSeq;

    @NotNull
    @Schema(description = "고인 이름")
    private String name;

    @NotNull
    @Schema(description = "생년월일")
    private String birth;

    @NotNull
    @Schema(description = "별세일자")
    private String goneDate;

    @NotNull
    @Schema(description = "묘비사진")
    private String graveImg;

    @Schema(description = "디지털 추모관 사진 목록")
    private List<String> memorialPhotoList;

    @NotNull
    @Schema(description = "디지털 추모관 사진 개수")
    private int photoCount;

    @Schema(description = "디지털 추모관 동영상 목록")
    private List<String> memorialVideoList;

    @Schema(description = "디지털 추모관 동영상 개수")
    private int videoCount;

    @Schema(description = "디지털 추모관 편지 목록")
    private List<MemorialLetter> memorialLetterList;

    @Schema(description = "디지털 추모관 편지 개수")
    private int letterCount;

}
