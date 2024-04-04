package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class MemorialLetterListResponseDto {
    @Schema(description = "추모관 편지 목록")
    private List<MemorialLetterDto> memorialLetterDtoList;

    @NotNull
    @Schema(description = "추모관 전체 편지 개수")
    private int count;
}
