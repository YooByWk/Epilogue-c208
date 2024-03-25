package com.epilogue.dto.request.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(description = "회원 정보 수정 DTO")
public class UpdateInfoRequestDto {

    @Schema(description = "변경할 이름")
    private String name;

    @Schema(description = "변경할 전화번호")
    private String mobile;
}
