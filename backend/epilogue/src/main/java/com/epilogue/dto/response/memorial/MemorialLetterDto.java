package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemorialLetterDto {
    @Schema(description = "작성자 닉네임")
    private String nickname;

    @NotNull
    @Schema(description = "편지 내용")
    private String content;

    @NotNull
    @Schema(description = "작성일")
    private String writtenDate;
}
