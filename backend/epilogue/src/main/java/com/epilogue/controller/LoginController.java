package com.epilogue.controller;

import com.epilogue.dto.request.user.JoinRequestDto;
import com.epilogue.dto.request.user.LoginRequestDto;
import com.epilogue.dto.response.user.LoginResponseDto;
import com.epilogue.util.JWTUtil;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.Cookie;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Tag(name = "login Controller", description = "로그인 관련 API")
@RestController
public class LoginController {

    private JWTUtil jwtUtil;

    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/login---------")
    public LoginResponseDto join(@Parameter(description = "로그인 요청 DTO") @RequestBody LoginRequestDto loginRequestDto) {
        String accessToken = jwtUtil.createAccessToken("ssafy", "user"); // access token

        return new LoginResponseDto(JWTUtil.ACCESS_TOKEN, "Bearer " + accessToken);


    }

}
