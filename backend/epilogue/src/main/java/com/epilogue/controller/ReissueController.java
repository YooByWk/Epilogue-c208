package com.epilogue.controller;

import com.epilogue.util.JWTUtil;
import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api")
@RequiredArgsConstructor
public class ReissueController {

    private final JWTUtil jwtUtil;
    private final StringRedisTemplate redisTemplate;

    @PostMapping("/reissue")
    public ResponseEntity<?> reissue(HttpServletResponse response) {

        //get refresh token
        String refresh;
        refresh = redisTemplate.opsForValue().get("Refresh_Token");

        if (refresh == null) {
            return new ResponseEntity<>("refresh token null", HttpStatus.BAD_REQUEST);
        } else {
            refresh = refresh.split(" ")[1];

        }

        //expired check
        try {
            jwtUtil.isExpired(refresh);
        } catch (ExpiredJwtException e) {

            //response status code
            return new ResponseEntity<>("refresh token expired", HttpStatus.BAD_REQUEST);
        }

        String username = jwtUtil.getUsername(refresh);
        String role = jwtUtil.getRole(refresh);

        //make new JWT
        String newAccess = jwtUtil.createAccessToken(username, role);

//        response
        response.setHeader(JWTUtil.ACCESS_TOKEN, newAccess);

        return new ResponseEntity<>(HttpStatus.OK);
    }
}