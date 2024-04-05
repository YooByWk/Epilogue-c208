package com.epilogue.dto.request.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "회원가입 요청 DTO")
public class JoinRequestDto {
    @NotNull(message = "아이디는 Null일 수 없습니다.")
    @Schema(description = "회원 아이디")
    private String userId;

    @NotNull(message = "비밀번호는 Null일 수 없습니다.")
    @Schema(description = "비밀번호")
    private String password;

    @NotNull(message = "이름은 Null일 수 없습니다.")
    @Schema(description = "이름")
    private String name;

    @NotNull(message = "휴대폰 번호는 Null일 수 없습니다.")
    @Schema(description = "휴대폰 번호")
    private String mobile;

    @NotNull(message = "생년월일은 Null일 수 없습니다.")
    @Schema(description = "생년월일")
    private String birth;
}
