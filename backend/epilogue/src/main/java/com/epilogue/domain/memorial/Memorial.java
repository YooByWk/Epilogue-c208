package com.epilogue.domain.memorial;

import com.epilogue.domain.user.User;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.sql.Timestamp;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "디지털 추모관")
@ToString
public class Memorial {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "디지털 추모관 식별키")
    private int memorialSeq;

    @NotNull
    @Schema(description = "회원 정보")
    @OneToOne
    private User user;

    @NotNull
    @Schema(description = "별세 일자")
    private String goneDate;

    @NotNull
    @Schema(description = "묘비명")
    private String graveName;

    @NotNull
    @Schema(description = "묘비 사진")
    private String graveImg;

    @NotNull
    @Schema(description = "디지털 추모관 생성일")
    private Timestamp createdDate;
}
