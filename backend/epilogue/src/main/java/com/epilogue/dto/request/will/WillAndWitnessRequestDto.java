package com.epilogue.dto.request.will;

import com.epilogue.dto.request.witness.WitnessRequestDto;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@AllArgsConstructor
@Schema(description = "유언 파일 및 증인 요청 DTO")
public class WillAndWitnessRequestDto {
    @NotNull(message = "증인 리스트는 Null일 수 없습니다.")
    @Schema(description = "증인 리스트")
    private List<WitnessRequestDto> witnessList;

    @NotNull(message = "유언 파일은 Null일 수 없습니다.")
    @Schema(description = "유언 파일")
    private MultipartFile multipartFile;
}
