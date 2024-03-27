package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemorialVideoDto {
    @Schema(description = "추모관 동영상 식별키")
    private int memorialVideoSeq;

    @NotNull
    @Schema(description = "S3 url")
    private String S3url;
}
