package com.epilogue.controller;

import com.amazonaws.Response;
import com.epilogue.dto.response.memorial.GraveDto;
import com.epilogue.dto.response.memorial.GraveResponseDto;
import com.epilogue.dto.response.memorial.MemorialResponseDto;
import com.epilogue.service.MemorialService;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/memorial")
@Tag(name = "Memorial Controller", description = "디지털 추모관 관련 API")
@Slf4j
public class MemorialController {

    private final MemorialService memorialService;

    @GetMapping("/list")
    @ApiResponse(responseCode = "200", description = "성공")
    public ResponseEntity<MemorialResponseDto> ViewMemorialList(Principal principal) {
        MemorialResponseDto memorialResponseDto = new MemorialResponseDto();

        if(principal != null) { // 회원
            String loginUserId = principal.getName();
            memorialResponseDto = memorialService.viewMemorialListByMember(loginUserId);
        } else { // 비회원
            memorialResponseDto = memorialService.viewMemorialListByNonMember();
        }

        return new ResponseEntity<>(memorialResponseDto, HttpStatus.OK);
    }

    @GetMapping("/{memorialSeq}")
    @ApiResponse(responseCode = "200", description = "성공")
    public ResponseEntity<GraveResponseDto> viewMemorial(@Parameter(description = "디지털 추모관 식별키") @PathVariable int memorialSeq) {
        GraveResponseDto graveResponseDto = memorialService.viewMemorial(memorialSeq);
        return new ResponseEntity<>(graveResponseDto, HttpStatus.OK);
    }

}
