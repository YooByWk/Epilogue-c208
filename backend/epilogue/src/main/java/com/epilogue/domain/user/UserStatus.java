package com.epilogue.domain.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@Schema(description = "회원 상태")
public enum UserStatus {
    LIVE, DEADANDSEND, DEADANDNOTSEND
}
