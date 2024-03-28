package com.epilogue.util;

import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JWTUtil {

    private SecretKey secretKey;
    public static final String ACCESS_TOKEN = "Access_Token";

    public JWTUtil(@Value("${spring.jwt.secret}") String secret) {


        secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
    }

    public String getUsername(String token) {

        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("userId", String.class);
    }

    public String getRole(String token) {

        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("role", String.class);
    }

    public Boolean isExpired(String token) {

        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().getExpiration().before(new Date());
    }

    public String createAccessToken(String userId, String role) {
        return Jwts.builder()
                .claim("userId", userId)
                .claim("role", role)
                .issuedAt(new Date(System.currentTimeMillis())) // 토큰 발행시간
                .expiration(new Date(System.currentTimeMillis() + 1209600000)) // 액세스토큰 만료기간 (1시간)
//                .expiration(new Date(System.currentTimeMillis() + 60)) // 액세스토큰 만료기간 (1시간)
                .signWith(secretKey) // 최종적으로 secretKey를 통해 토큰 암호화
                .compact();
    }

}