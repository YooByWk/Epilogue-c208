package com.epilogue.util;

import com.epilogue.dto.response.user.CustomUserDetails;
import com.epilogue.repository.user.UserRepository;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.io.IOException;
import java.time.Duration;
import java.util.Collection;
import java.util.Iterator;

@RequiredArgsConstructor
@Slf4j
public class LoginFilter extends UsernamePasswordAuthenticationFilter {

    private final AuthenticationManager authenticationManager;
    private final StringRedisTemplate redisTemplate;
    private final JWTUtil jwtUtil;

    public LoginFilter(String defaultFilterProcessUrl, AuthenticationManager authenticationManager, StringRedisTemplate redisTemplate, JWTUtil jwtUtil) {
        super.setFilterProcessesUrl(defaultFilterProcessUrl);
        this.authenticationManager = authenticationManager;
        this.redisTemplate = redisTemplate;
        this.jwtUtil = jwtUtil;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {

        String userId = obtainUsername(request);
        String password = obtainPassword(request);

        log.info("=============================================");
        log.info("userId : {}", userId);
        log.info("password : {}", password);

        // 스프링 시큐리티에서 아이디와 비밀번호를 검증하기 위해서는 token에 담아야 함
        UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userId, password, null);

        // token에 담은 데이터를 검증을 위해 AuthenticationManager로 전달
        return authenticationManager.authenticate(authToken);
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) {
        // 유저 정보
        // 로그인 성공 -> 로그인한 유저의 정보를 가지고 JWT 발급
        // getPrincipal() : 현재 사용자 정보 가져오기
        CustomUserDetails customUserDetails = (CustomUserDetails) authentication.getPrincipal();
        String userId = customUserDetails.getUsername(); // 아이디
        log.info("=============================================");
        log.info("successfulAuthentication 의 userId : {}", userId);
        log.info("successfulAuthentication 의 password : {}", customUserDetails.getPassword());

        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
        GrantedAuthority auth = iterator.next();
        String role = auth.getAuthority(); // 권한

        // 사용자 아이디, 권한 입력해서 JWT 발급
        String accessToken = jwtUtil.createAccessToken(userId, role); // access token
        String refreshToken = jwtUtil.createRefreshToken(userId, role); // refresh token

        // Bearer 인증 방식
        // 응답 헤더에 JWT 토큰 값을 넣어 응답
        // 응답 헤더에서 "Authorization" key 값에 "Bearer ~~" 값을 확인할 수 있음 (JWT)
        response.addHeader(JWTUtil.ACCESS_TOKEN, "Bearer " + accessToken);

        // Redis refreshToken 저장
        redisTemplate.opsForValue().set(JWTUtil.REFRESH_TOKEN, "Bearer " + refreshToken);
    }

    // 로그인 실패시 실행하는 메소드
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) throws IOException, ServletException {

        // 로그인 실패 시 401 응답 (Unauthorized)
        response.setStatus(401);
    }

}
