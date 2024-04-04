package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemorialPhotoDto {
    @Schema(description = "추모관 사진 식별키")
    private int memorialPhotoSeq;

    @NotNull
    @Schema(description = "S3 url")
    private String S3url;
}
