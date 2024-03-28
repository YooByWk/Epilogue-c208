package com.epilogue.dto.request.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "디지털 추모관 사진/영상 업로드 요청 DTO")
public class MemorialMediaRequestDto {

    @Schema(description = "설명 내용")
    private String content;
}
