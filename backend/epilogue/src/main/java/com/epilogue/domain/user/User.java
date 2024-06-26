package com.epilogue.domain.user;

import com.epilogue.domain.will.Will;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Entity
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "회원")
@ToString
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "회원 식별키")
    private int userSeq;
    
    @NotNull(message = "회원 아이디는 Null일 수 없습니다.")
    @Schema(description = "회원 아이디")
    private String userId;

    @NotNull(message = "비밀번호는 Null일 수 없습니다.")
    @Schema(description = "비밀번호")
    private String password;
    
    @NotNull(message = "이름은 Null일 수 없습니다.")
    @Schema(description = "이름")
    private String name;
    
    @NotNull(message = "휴대폰 번호는 Null일 수 없습니다.")
    @Schema(description = "휴대폰 번호")
    private String mobile;
    
    @NotNull(message = "생일은 Null일 수 없습니다.")
    @Schema(description = "생일")
    private String birth;

    @Schema(description = "유언")
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Will will;

    @Enumerated(EnumType.STRING)
    private UserStatus userStatus;

    public void updateUserInfo(String name, String mobile) {
        this.name = name;
        this.mobile = mobile;
    }

    public void updateWill(Will will) {
        this.will = will;
    }

    public void updateWillNull() {
        this.will = null;
    }

    public void updateUserStatus() {
        this.userStatus = UserStatus.DEADANDSEND;
    }
}
