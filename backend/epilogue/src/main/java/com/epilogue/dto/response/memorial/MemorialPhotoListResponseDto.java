package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class MemorialPhotoListResponseDto {
    @Schema(description = "추모관 사진 목록")
    private List<MemorialPhotoDto> memorialPhotoDtoList;

    @NotNull
    @Schema(description = "추모관 전체 사진 개수")
    private int count;
}
