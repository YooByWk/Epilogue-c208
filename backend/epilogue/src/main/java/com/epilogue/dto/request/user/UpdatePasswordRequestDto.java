package com.epilogue.dto.request.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "변경할 비밀번호 DTO")
public class UpdatePasswordRequestDto {

    @Schema(description = "변경할 비밀번호")
    private String password;
}
