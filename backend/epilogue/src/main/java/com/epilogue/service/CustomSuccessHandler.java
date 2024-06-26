package com.epilogue.service;


import com.epilogue.domain.auth.CustomOAuth2User;
import com.epilogue.util.JWTUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

@Component
@RequiredArgsConstructor

public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final JWTUtil jwtUtil;
    private final StringRedisTemplate redisTemplate;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        System.out.println("==========================");
        System.out.println(authentication.getPrincipal().toString());
        System.out.println("=============================");
        //OAuth2User
        CustomOAuth2User customUserDetails = (CustomOAuth2User) authentication.getPrincipal();
        String username = customUserDetails.getUsername();

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
        GrantedAuthority auth = iterator.next();
        String role = auth.getAuthority();

        //토큰 설정

        String accessToken = jwtUtil.createAccessToken(username, role); // access token
        String refreshToken = jwtUtil.createRefreshToken(username, role); // refresh token

        // Bearer 인증 방식
        // 응답 헤더에 JWT 토큰 값을 넣어 응답
        // 응답 헤더에서 "Authorization" key 값에 "Bearer ~~" 값을 확인할 수 있음 (JWT)
        response.addHeader(JWTUtil.ACCESS_TOKEN, "Bearer " + accessToken);

        // Redis refreshToken 저장
        redisTemplate.opsForValue().set(JWTUtil.REFRESH_TOKEN, "Bearer " + refreshToken);

    }
}
