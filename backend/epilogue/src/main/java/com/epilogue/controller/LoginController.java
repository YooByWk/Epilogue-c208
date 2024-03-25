package com.epilogue.controller;

import com.epilogue.dto.request.user.JoinRequestDto;
import com.epilogue.dto.request.user.LoginRequestDto;
import com.epilogue.dto.response.user.LoginResponseDto;
import com.epilogue.util.JWTUtil;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Tag(name = "login Controller", description = "로그인 관련 API")
@RestController
@RequiredArgsConstructor
public class LoginController {

    private final JWTUtil jwtUtil;

    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/login---------")
    public ResponseEntity<Void> join(HttpServletResponse response, @Parameter(description = "로그인 요청 DTO") @RequestBody LoginRequestDto loginRequestDto) {
        String accessToken = jwtUtil.createAccessToken(loginRequestDto.getUsername(), "user"); // access token
        // 응답 헤더에서 "Authorization" key 값에 "Bearer ~~" 값을 확인할 수 있음 (JWT)
        response.addHeader(JWTUtil.ACCESS_TOKEN, "Bearer " + accessToken);
        return new ResponseEntity<>(HttpStatus.OK);


    }

}
