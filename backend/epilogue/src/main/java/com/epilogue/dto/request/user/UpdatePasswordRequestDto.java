package com.epilogue.dto.request.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "변경할 비밀번호 DTO")
public class UpdatePasswordRequestDto {

    @Schema(description = "변경할 비밀번호")
    private String password;
}
