package com.epilogue.domain.viewer;

import com.epilogue.domain.will.Will;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "열람인")
public class Viewer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "열람인 식별키")
    private int viewerSeq;

    @NotNull(message = "유언 식별키는 Null일 수 없습니다.")
    @Schema(description = "유언 식별키")
    @ManyToOne
    private Will will;

    @NotNull(message = "열람인 이름은 Null일 수 없습니다.")
    @Schema(description = "열람인 이름")
    private String viewerName;

    @Schema(description = "열람인 이메일")
    private String viewerEmail;

    @Schema(description = "열람인 휴대폰 번호")
    private String viewerPhone;
}
