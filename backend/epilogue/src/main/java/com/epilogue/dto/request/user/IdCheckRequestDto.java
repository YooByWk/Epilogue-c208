package com.epilogue.dto.request.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "아이디 중복체크 요청 DTO")
public class IdCheckRequestDto {

    @Schema(description = "회원 아이디")
    private String userId;
}
