package com.epilogue.domain.memorial;

import com.epilogue.domain.user.User;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "즐겨찾기")
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "즐겨찾기 식별키")
    private int favoriteSeq;

    @NotNull
    @Schema(description = "즐겨찾기 한 회원 식별키")
    @ManyToOne
    private User user;

    @NotNull
    @Schema(description = "디지털 추모관")
    @ManyToOne // 즐겨찾기와 추모관은 '다대일 단방향' 관계
    private Memorial memorial;
}
