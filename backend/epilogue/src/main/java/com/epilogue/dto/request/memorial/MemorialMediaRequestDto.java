package com.epilogue.dto.request.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Getter
//@RequiredArgsConstructor
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "디지털 추모관 사진/영상 업로드 요청 DTO")
public class MemorialMediaRequestDto {
//    @NotNull
//    @Schema(description = "사진/영상 파일")
//    private MultipartFile multipartFile;

    @Schema(description = "설명 내용")
    private String content;
}
