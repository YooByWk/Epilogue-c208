package com.epilogue.util.jwt;
import io.jsonwebtoken.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Date;

// JWT 발급과 검증에 필요한 메서드를 제공하는 클래스
@Component
@Slf4j
public class JWTUtil {

    public static final String ACCESS_TOKEN = "Access_Token";
    public static final String REFRESH_TOKEN = "Refresh_Token";

    private final SecretKey secretKey; // JWT 암호화 키

    public JWTUtil(@Value("${spring.jwt.secret}") String secret) {
        this.secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
    }

    // JWT 검증에 필요한 메서드들
    public String getUserId(String token) {
        // jwt parser를 이용하고 secretKey를 이용하여 검증
        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("userId", String.class);
    }

    public String getRole(String token) {
        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("role", String.class);
    }

    public boolean isExpired(String token) {
        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().getExpiration().before(new Date());
    }

    // AccessToken 생성 메서드
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

    // Refresh 생성 메서드
    public String createRefreshToken(String userId, String role) {
        return Jwts.builder()
                .claim("userId", userId)
                .claim("role", role)
                .issuedAt(new Date(System.currentTimeMillis())) // 토큰 발행시간
                .expiration(new Date(System.currentTimeMillis() + 1209600000)) // 리프레시토큰 만료기간(2주)
                .signWith(secretKey) // 최종적으로 secretKey를 통해 토큰 암호화
                .compact();
    }

    public boolean validateToken(String jwt) {
        return this.getClaims(jwt) != null;
    }

    private Jws<Claims> getClaims(String token) {
        try {
            return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token);
        } catch (SignatureException ex) {
            log.error("Invalid JWT signature");
            throw ex;
        } catch (MalformedJwtException ex) {
            log.error("Invalid JWT token");
            throw ex;
        } catch (ExpiredJwtException ex) {
            log.error("Expired JWT token");
            throw ex;
        } catch (UnsupportedJwtException ex) {
            log.error("Unsupported JWT token");
            throw ex;
        } catch (IllegalArgumentException ex) {
            log.error("JWT claims string is empty.");
            throw ex;
        }
    }
}