package com.epilogue.dto.request.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MemorialLetterRequestDto {
    @Schema(description = "작성자 닉네임")
    private String nickname;

    @Schema(description = "내용")
    private String content;
}
