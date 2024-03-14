package com.epilogue.domain.user;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userSeq; // idx
    @NotNull
    private String userId; // 아이디
    @NotNull
    private String name; // 이름
    private String nickname; // 닉네임
    private String password; // 비밀번호
    @NotNull
    private String email; // 이메일
    @NotNull
    private String phone; // 핸드폰 번호
    @NotNull
    private String birth; // 생년월일
    @NotNull
    private String gender; // 성별
    @NotNull
    private String role; // 권한 (counselor, client, admin)
    private String refreshToken; // refresh token

    @Column(columnDefinition = "TEXT")
    private String profileImg; // 프로필 사진
    private String professionalField; // 전문분야
    private int careerPeriod; // 경력
    private double grade; // 평점
    private String comment; // 소개 멘트
    private String type; // 타입 (kakao, naver)

    private String alramMessage;
    private int readCheck; // 안 읽었으면 1 , 읽었으면 0

    private String educationField; // 학력사항
    private String certificateField; // 자격증

    public void updatePassword(String password) {
        this.password = password;
    }

}
