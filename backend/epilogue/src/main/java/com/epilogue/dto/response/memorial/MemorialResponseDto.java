package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.util.List;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemorialResponseDto {

    @Schema(name = "즐겨찾기한 추모관 목록")
    private List<GraveDto> favoriteMemorialList;

    @Schema(name = "최신순 추모관 목록")
    private List<GraveDto> memorialList;

}
