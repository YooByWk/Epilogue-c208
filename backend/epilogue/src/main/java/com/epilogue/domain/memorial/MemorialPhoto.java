package com.epilogue.domain.memorial;

import com.epilogue.domain.user.User;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Getter
public class MemorialPhoto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "사진 식별키")
    private int memorialPhotoSeq;

    @Schema(description = "사진 객체 url")
    private String photoURL;

    @ManyToOne
    @Schema(description = "디지털 추모관 정보")
    private Memorial memorial;

    @ManyToOne
    @Schema(description = "업로드한 회원 식별키")
    private User user;
}
