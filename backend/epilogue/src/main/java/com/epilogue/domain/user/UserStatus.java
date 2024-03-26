package com.epilogue.domain.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "회원 상태")
public class UserStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "회원 상태 식별키")
    private int userStatusSeq;

    @NotNull(message = "회원 상태는 Null일 수 없습니다.")
    @Schema(description = "회원 상태(생사 및 유언장 전송 상태) : live(생존), deadAndSend(사망 및 전송 o), deadAndNotSend(사망 및 전송 x)")
    @Enumerated(EnumType.STRING)
    private Status status;

    public enum Status {
        Live,
        DeadAndSend,
        DeadAndNotSend
    }

}
