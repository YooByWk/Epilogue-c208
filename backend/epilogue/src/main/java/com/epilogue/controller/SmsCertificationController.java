package com.epilogue.controller;

import com.epilogue.dto.request.user.SmsCertificationRequest;
import com.epilogue.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.amazonaws.util.AWSRequestMetrics.Field.StatusCode;

@RestController
@RequiredArgsConstructor
@RequestMapping("/sms-certification")
public class SmsCertificationController {
    private final UserService userService;

    @PostMapping("/send")
    public ResponseEntity<?> sendSms(@RequestBody SmsCertificationRequest requestDto) {
        userService.sendSms(requestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    //인증번호 확인
    @PostMapping("/confirm")
    public ResponseEntity<Void> SmsVerification(@RequestBody SmsCertificationRequest requestDto) {
        userService.verifySms(requestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
