package com.epilogue.domain.user;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userSeq; // 회원 식별키
    @NotNull
    private String userId; // 아이디
    private String password; // 비밀번호
    @NotNull
    private String name; // 이름
    @NotNull
    private String phone; // 핸드폰 번호
    @NotNull
    private String birth; // 생년월일
}
