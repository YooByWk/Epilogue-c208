package com.epilogue.controller;

import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.service.WillService;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "Will Controller", description = "유언 관련 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/will")
public class WillController {
    private final WillService willService;

    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping
    public ResponseEntity<?> createWill(@Parameter(description = "유언 작성 DTO") @RequestBody WillRequestDto willRequestDto) {
        willService.create(willRequestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
