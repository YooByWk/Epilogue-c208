package com.epilogue.domain.witness;

import com.epilogue.domain.will.Will;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "증인")
public class Witness {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "증인 식별키")
    private int witnessSeq;

    @NotNull(message = "유언 식별키는 Null일 수 없습니다.")
    @Schema(description = "유언 식별키")
    @ManyToOne
    private Will will;

    @NotNull(message = "증인 이름은 Null일 수 없습니다.")
    @Schema(description = "증인 이름")
    private String witnessName;

    @NotNull(message = "증인 이메일은 Null일 수 없습니다.")
    @Schema(description = "증인 이메일")
    private String witnessEmail;

    @NotNull(message = "증인 휴대폰 번호는 Null일 수 없습니다.")
    @Schema(description = "증인 휴대폰 번호")
    private String witnessPhone;

    @NotNull(message = "증인 코드는 Null일 수 없습니다.")
    @Schema(description = "증인 코드")
    private String witnessCode;

}
