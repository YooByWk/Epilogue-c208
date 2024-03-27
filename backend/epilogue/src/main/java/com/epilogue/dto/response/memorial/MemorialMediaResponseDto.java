package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemorialMediaResponseDto {
    @NotNull
    @Schema(description = "S3 url")
    private String S3url;

    @Schema(description = "설명 내용")
    private String content;
}
