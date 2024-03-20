package com.epilogue.dto.response.memorial;

import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

public class MemorialResponseDto {

    @Schema(name = "즐겨찾기한 추모관 목록")
    List<MemorialDto> favoriteMemorialList;

    @Schema(name = "최신순 추모관 목록")
    List<MemorialDto> memorialList;

}
