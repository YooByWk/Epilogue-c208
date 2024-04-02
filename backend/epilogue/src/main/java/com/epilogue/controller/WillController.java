package com.epilogue.controller;

import com.epilogue.domain.will.Will;
import com.epilogue.dto.request.viewer.ViewerRequestDto;
import com.epilogue.dto.request.will.WillAdditionalRequestDto;
import com.epilogue.dto.request.will.WillApplyRequestDto;
import com.epilogue.dto.request.will.WillMemorialRequestDto;
import com.epilogue.dto.request.witness.WitnessRequestDto;
import com.epilogue.dto.response.WillResponseDto;
import com.epilogue.service.AwsS3Service;
import com.epilogue.service.ViewerService;
import com.epilogue.service.WillService;
import com.epilogue.service.WitnessService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.security.Principal;
import java.util.List;

@Slf4j
@Tag(name = "Will Controller", description = "유언 관련 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class WillController {
    private final WillService willService;
    private final WitnessService witnessService;
    private final ViewerService viewerService;
    private final AwsS3Service awsS3Service;

    @Operation(summary = "증인 저장 API", description = "증인 목록을 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/will/witness")
    public ResponseEntity<Void> saveWitness(@Parameter(description = "증인 목록") @RequestBody List<WitnessRequestDto> witnessList, Principal principal) {
        // 임의 유언 생성
        Will will = new Will();
        willService.saveWill(will);

        // 증인 리스트 저장
        witnessService.saveWitness(will, witnessList, principal);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "유언 파일 저장 API", description = "유언 파일을 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/will")
    public ResponseEntity<Void> saveWill(@Parameter(description = "유언 열람 파일") @RequestPart MultipartFile multipartFile, Principal principal) {
        // 유언 파일 S3 저장 (원본 파일, 초기 영수증)
        awsS3Service.uploadWill(multipartFile, principal);

        // 프론트에 알림 (200 보내기)
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "열람인 저장 API", description = "열람인 목록을 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/will/viewer")
    public ResponseEntity<Void> saveViewer(@Parameter(description = "열람인 목록") @RequestBody List<ViewerRequestDto> viewerList, Principal principal) {
        // 열람인 리스트 저장
        viewerService.save(viewerList, principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "묘비 사진 저장 API", description = "묘비 사진을 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/will/graveImage")
    public ResponseEntity<Void> saveGraveImage(@Parameter(description = "묘비 사진 파일") @RequestPart MultipartFile multipartFile, Principal principal) {
        // 묘비 사진 S3 저장
        awsS3Service.uploadGraveImage(multipartFile, principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "디지털 추모관 사용 여부 및 묘비 이름 저장 API", description = "디지털 추모관 사용 여부 및 묘비 이름을 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/will/memorialAndGraveName")
    public ResponseEntity<Void> saveMemorial(@Parameter(description = "디지털 추모관 정보 요청 DTO")  @RequestBody WillMemorialRequestDto willMemorialRequestDto, Principal principal) {
        // 디지털 추모관 정보 저장
        willService.saveMemorial(willMemorialRequestDto, principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "추가 정보 저장 API", description = "추가 정보를 저장합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/will/additional")
    public ResponseEntity<Void> saveAdditionalInformation(@Parameter(description = "추가 정보 요청 DTO") @RequestBody WillAdditionalRequestDto willAdditionalRequestDto, Principal principal) {
        // 추가 정보 저장
        willService.saveAdditionalInformation(willAdditionalRequestDto, principal);
        willService.sendWillApplyLink(principal);

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "나의 유언 조회 API", description = "내가 작성한 유언을 조회합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @GetMapping("/myWill")
    public ResponseEntity<WillResponseDto> viewMyWill(Principal principal) {
        if (willService.viewMyWill(principal) == null) return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        return new ResponseEntity<>(willService.viewMyWill(principal), HttpStatus.OK);
    }

    @Operation(summary = "나의 유언 삭제 API", description = "내가 작성한 유언을 삭제합니다.")
    @ApiResponse(responseCode = "200", description = "성공")
    @DeleteMapping("/myWill")
    public ResponseEntity<Void> deleteMyWill(Principal principal) throws MalformedURLException, UnsupportedEncodingException {
        willService.deleteMyWill(principal);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @CrossOrigin
    @Operation(summary = "유언 열람 신청 API", description = "유언 열람을 신청합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "true", description = "인증 성공"),
            @ApiResponse(responseCode = "false", description = "인증 실패"),
    })
    @PostMapping("/will/apply")
    public ResponseEntity<Boolean> applyWill(@Parameter(description = "유언 열람 인증 요청 DTO") @RequestBody WillApplyRequestDto willApplyRequestDto) {
        return new ResponseEntity<>(willService.applyWill(willApplyRequestDto), HttpStatus.OK);
    }

    @CrossOrigin
    @Operation(summary = "인증 코드 확인 API", description = "열람인의 인증 코드를 확인합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200과 유언 파일 주소(String)", description = "인증 성공"),
            @ApiResponse(responseCode = "404", description = "인증 실패"),
    })
    @PostMapping("/will/certificate")
    public ResponseEntity<?> certificateCode(@Parameter(description = "유언 인증 코드") String willCode) {
        Will will = willService.certificateCode(willCode);
        if (will != null) return new ResponseEntity<>(willService.getMyWill(will.getWillSeq()), HttpStatus.OK);
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}
