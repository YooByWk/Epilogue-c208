package com.epilogue.controller;

import com.epilogue.dto.request.user.SmsCertificationRequestDto;
import com.epilogue.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "SmsCertificationController", description = "휴대폰 인증 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/sms-certification")
public class SmsCertificationController {
    private final UserService userService;

    @Operation(summary = "SMS 본인 인증 메세지 전송 API")
    @PostMapping("/send")
    @ApiResponse(responseCode = "200", description = "성공")
    public ResponseEntity<?> sendSms(@Parameter(description = "인증 요청") @RequestBody SmsCertificationRequestDto smsCertificationRequestDto) {
        userService.sendSms(smsCertificationRequestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    //인증번호 확인
    @Operation(summary = "SMS 본인인증 인증번호 확인 API")
    @PostMapping("/confirm")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "true", description = "인증 성공"),
            @ApiResponse(responseCode = "false", description = "인증 실패"),
    })
    public ResponseEntity<Boolean> SmsVerification(@Parameter(description = "인증 확인") @RequestBody SmsCertificationRequestDto smsCertificationRequestDto) {
        boolean result = userService.verifySms(smsCertificationRequestDto);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

}
