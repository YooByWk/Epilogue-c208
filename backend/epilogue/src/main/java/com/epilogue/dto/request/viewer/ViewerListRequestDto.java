package com.epilogue.dto.request.viewer;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@Schema(description = "열람인 목록 요청 DTO")
public class ViewerListRequestDto {
    @NotNull(message = "열람인 리스트는 Null일 수 없습니다.")
    @Schema(description = "열람인 리스트")
    private List<ViewerRequestDto> viewerList;
}
