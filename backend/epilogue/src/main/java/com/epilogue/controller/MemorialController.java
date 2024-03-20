package com.epilogue.controller;

import com.epilogue.dto.response.memorial.MemorialResponseDto;
import com.epilogue.service.MemorialService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
@Tag(name = "Memorial Controller", description = "디지털 추모관 관련 API")
public class MemorialController {

    private final MemorialService memorialService;

    @GetMapping("/memorial/list")
    @ApiResponse(responseCode = "200", description = "성공")
    public ResponseEntity<List<MemorialResponseDto>> ViewMemorialList(Principal principal) {
        String loginUserId = principal.getName();
        List<MemorialResponseDto> memorialList = memorialService.viewMemorialList(loginUserId);
        return new ResponseEntity<>(memorialList, HttpStatus.OK);
    }

}
