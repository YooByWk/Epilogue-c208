package com.epilogue.controller;

import com.epilogue.domain.will.Will;
import com.epilogue.dto.request.viewer.ViewerRequestDto;
import com.epilogue.dto.request.will.WillAdditionalRequestDto;
import com.epilogue.dto.request.will.WillApplyRequestDto;
import com.epilogue.dto.request.will.WillMemorialRequestDto;
import com.epilogue.dto.request.witness.WitnessRequestDto;
import com.epilogue.service.AwsS3Service;
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
import org.springframework.web.multipart.MultipartFile;

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
    private final AwsS3Service awsS3Service;

    @Operation(summary = "유언 파일 및 증인 저장 API", description = "유언 파일 및 증인을 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping(value = "/willAndWitness")
    public ResponseEntity<Void> saveWillAndWitness(@RequestPart MultipartFile multipartFile, @RequestPart List<WitnessRequestDto> witnessList, Principal principal) {
        // 임의 유언 생성
        Will will = new Will();
        willService.saveWill(will);

        log.info("will 저장 완료! will={}", will);

        // 증인 리스트 저장
        witnessService.saveWitness(will, witnessList, principal);
        log.info("witness 저장 완료!");

        // 블록체인 트랜잭션 생성 (해시, 녹음 파일 url, 초기 영수증)

        // 블록체인 생성이 성공적으로 됐을 경우


        // 유언 파일 S3 저장 (원본 파일, 초기 영수증)
        awsS3Service.upload(multipartFile, principal);

        log.info("유언 파일 저장 완료!");

        // 프론트에 알림 (200 보내기)
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "열람인 저장 API", description = "열람인을 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/viewer")
    public ResponseEntity<Void> saveViewer(@Parameter(description = "열람인 요청 DTO") @RequestBody List<ViewerRequestDto> viewerList, Principal principal) {
        // 열람인 리스트 저장
        viewerService.save(viewerList, principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "디지털 추모관 정보 저장 API", description = "디지털 추모관 정보를 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/memorial")
    public ResponseEntity<Void> saveMemorial(@Parameter(description = "디지털 추모관 정보 요청 DTO") @ModelAttribute WillMemorialRequestDto willMemorialRequestDto, Principal principal) {
        // 열람인 리스트 저장
        willService.saveMemorial(willMemorialRequestDto, principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "추가 정보 저장 API", description = "추가 정보를 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/additional")
    public ResponseEntity<Void> saveAdditionalInformation(@Parameter(description = "추가 정보 요청 DTO") @RequestBody WillAdditionalRequestDto willAdditionalRequestDto, Principal principal) {
        // 열람인 리스트 저장
        willService.saveAdditionalInformation(willAdditionalRequestDto, principal);
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

        // S3에서 유언 원본 파일 삭제
//        awsS3Service.deleteMp3FromS3(mp3Address);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "유언 열람 신청 API", description = "유언 열람을 신청합니다. 인증에 성공할 경우 true, 실패할 경우 false를 반환합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/apply")
    public ResponseEntity<Boolean> applyWill(@Parameter(description = "유언 열람 인증 요청 DTO") @RequestBody WillApplyRequestDto willApplyRequestDto) {
        return new ResponseEntity<>(willService.applyWill(willApplyRequestDto), HttpStatus.OK);
    }
}
