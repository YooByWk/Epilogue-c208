package com.epilogue.domain.user;

import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "회원")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "회원 식별키")
    private int userSeq;
    
    @NotNull
    @Schema(description = "회원 아이디")
    private String userId;
    
    @Schema(description = "회원 비밀번호")
    private String password;
    
    @NotNull
    @Schema(description = "회원 이름")
    private String name;
    
    @NotNull
    @Schema(description = "회원 전화번호")
    private String phone;
    
    @NotNull
    @Schema(description = "회원 생일")
    private String birth;

    @Schema(description = "refresh token")
    private String refreshToken;

    public User(String userId, String name, String phone, String birth) {
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.birth = birth;
    }

    public User(String userId) {
        this.userId = userId;
    }

    public void updateRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }
}
