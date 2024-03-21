package com.epilogue.controller;

import com.epilogue.domain.will.Will;
import com.epilogue.dto.request.will.WillApplyRequestDto;
import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.repository.viewer.ViewerRepository;
import com.epilogue.service.ViewerService;
import com.epilogue.service.WillService;
import com.epilogue.service.WitnessService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Slf4j
@Tag(name = "Will Controller", description = "유언 관련 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/will")
public class WillController {
    private final WillService willService;
    private final WitnessService witnessService;
    private final ViewerService viewerService;

    @Operation(summary = "유언 작성 API", description = "유언을 작성하면 블록체인을 생성한 뒤, S3에 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping
    // 녹음 파일 Form-Data 형식으로 따로 받기
    public ResponseEntity<Void> createWill(@Parameter(description = "유언 작성 요청 DTO") @RequestBody WillRequestDto willRequestDto, Principal principal) {
        // 유언 관련 정보 저장
        Will will = willService.create(willRequestDto, principal);
        int willSeq = will.getWillSeq();

        // 증인 리스트 저장
        witnessService.create(willSeq, willRequestDto);

        // 열람인 리스트 저장
        viewerService.create(willSeq, willRequestDto);

        // 블록체인 트랜잭션 생성 (해시, 녹음 파일 url, 초기 영수증)

        // 블록체인 생성이 성공적으로 됐을 경우

        // 1. 프론트에 알림 (200 보내기)

        // 2. S3 서버 저장 (원본 파일, 초기 영수증)

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "나의 유언 조회 API", description = "내가 작성한 유언을 조회합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @GetMapping
    public ResponseEntity<Void> viewMyWill(Principal principal) {
        willService.viewMyWill(principal);
        // S3에서 가져온 유언 파일 반환
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "나의 유언 삭제 API", description = "내가 작성한 유언을 삭제합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @DeleteMapping
    public ResponseEntity<Void> deleteMyWill(Principal principal) {
        willService.deleteMyWill(principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "유언 열람 신청 API", description = "유언 열람을 신청합니다. 인증에 성공할 경우 true, 실패할 경우 false를 반환합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/apply")
    public ResponseEntity<Boolean> applyWill(@Parameter(description = "유언 열람 인증 요청 DTO") @RequestBody WillApplyRequestDto willApplyRequestDto) {
        return new ResponseEntity<>(willService.applyWill(willApplyRequestDto), HttpStatus.OK);
    }
}
