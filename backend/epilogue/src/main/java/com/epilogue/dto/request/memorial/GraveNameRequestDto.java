package com.epilogue.dto.request.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Schema(description = "묘지명으로 검색 요청 DTO")

@NoArgsConstructor
@AllArgsConstructor
public class GraveNameRequestDto {
    @Schema(description = "검색할 묘지명")
    private String graveName;
}
