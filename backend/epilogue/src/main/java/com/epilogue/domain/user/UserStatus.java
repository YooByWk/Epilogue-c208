package com.epilogue.domain.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Schema(description = "회원 상태")
public enum UserStatus {
    LIVE, DEADANDSEND, DEADANDNOTSEND
}
