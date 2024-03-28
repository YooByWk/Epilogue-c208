package com.epilogue.dto.request.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Schema(description = "이름으로 검색 요청 DTO")
@NoArgsConstructor
@AllArgsConstructor
public class NameRequestDto {

    @Schema(description = "검색할 이름")
    private String name;
}
