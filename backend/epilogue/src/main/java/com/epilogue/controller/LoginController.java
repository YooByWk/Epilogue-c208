package com.epilogue.controller;

import com.epilogue.dto.request.user.JoinRequestDto;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Tag(name = "login Controller", description = "로그인 관련 API")
public class LoginController {

    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/user/join")
    public void join(@Parameter(description = "회원가입 요청 DTO") @RequestBody JoinRequestDto joinRequestDto) {
    }

}
