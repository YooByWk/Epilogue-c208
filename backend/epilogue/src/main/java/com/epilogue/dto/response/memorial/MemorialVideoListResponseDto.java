package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class MemorialVideoListResponseDto {
    @Schema(description = "추모관 동영상 목록")
    private List<MemorialVideoDto> memorialVideoDtoList;

    @NotNull
    @Schema(description = "추모관 전체 동영상 개수")
    private int count;
}
