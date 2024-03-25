package com.epilogue.domain.memorial;

import com.epilogue.domain.user.User;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Entity
@Getter
@Schema(description = "즐겨찾기")
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "즐겨찾기 식별키")
    private int favoriteSeq;

    @NotNull
    @Schema(description = "즐겨찾기 한 회원 식별키")
//    private int userSeq;
    private User user;

    @NotNull
    @Schema(description = "디지털 추모관")
    @ManyToOne // 즐겨찾기와 추모관은 '다대일 단방향' 관계
    @JoinColumn(name = "memorial_seq")
    private Memorial memorial;
}
