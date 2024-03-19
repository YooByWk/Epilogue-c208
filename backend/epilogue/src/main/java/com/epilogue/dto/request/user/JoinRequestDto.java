package com.epilogue.dto.request.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "회원가입 요청 DTO")
public class JoinRequestDto {
    @Schema(description = "회원 아이디")
    private String userId;

    @Schema(description = "비밀번호")
    private String password;

    @Schema(description = "이름")
    private String name;

    @Schema(description = "휴대폰 번호")
    private String phone;

    @Schema(description = "생년월일")
    private String birth;
}
