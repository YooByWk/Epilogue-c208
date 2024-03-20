package com.epilogue.controller;

import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.service.WillService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Tag(name = "Will Controller", description = "유언 관련 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/will")
public class WillController {
    private final WillService willService;

    @Operation(summary = "유언 작성 API", description = "유언을 작성하고 블록체인에 저장한 뒤 S3에 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping
    public ResponseEntity<?> createWill(@Parameter(description = "유언 작성 DTO") @RequestBody WillRequestDto willRequestDto) {
        // 유언 관련 정보 저장
        willService.create(willRequestDto);

        // 블록체인 트랜잭션 생성 (해시, 녹음 파일 url, 초기 영수증)

        // 블록체인 생성이 성공적으로 됐을 경우

        // 1. 프론트에 알림 (200 보내기)

        // 2. S3 서버 저장 (원본 파일, 초기 영수증)

        return new ResponseEntity<>(HttpStatus.OK);
    }

//    @Operation(summary = "유언 작성 API", description = "유언을 작성하고 블록체인에 저장한 뒤 S3에 저장합니다.")
//    @ApiResponse(responseCode = "200", description = "성공")
//    @GetMapping("/text")
//    public ResponseEntity<?> viewTextWill(Principal principal) {
//
//    }

}
