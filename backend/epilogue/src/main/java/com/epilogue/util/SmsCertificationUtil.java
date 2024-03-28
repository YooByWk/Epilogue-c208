package com.epilogue.util;

import jakarta.annotation.PostConstruct;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class SmsCertificationUtil {

    @Value("${coolsms.api.key}")
    private String apiKey;
    @Value("${coolsms.api.secret}")
    private String apiSecretKey;

    private DefaultMessageService messageService;

    @PostConstruct
    private void init(){
        this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecretKey, "https://api.coolsms.co.kr");
    }

    // 단일 메시지 발송 예제
    public SingleMessageSentResponse sendSms(String to, String verificationCode) {
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01038620912");
        message.setTo(to);
        message.setText("[E:pilogue] 본인 확인 인증번호는 " + verificationCode + "입니다.");

        return this.messageService.sendOne(new SingleMessageSendingRequest(message));
    }

    public SingleMessageSentResponse sendWillApplyLink(String to, String name, String witnessCode) {
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01057056540");
        message.setTo(to);
        message.setText("[Epilogue] " + name + "님의 유언 열람을 신청할 수 있습니다.\n유언 열람 신청 전, 사망진단서와 아래의 인증코드를 미리 준비해주세요.\n- 유언 열람 신청 링크 : http://j10c208.p.ssafy.io/\n- 인증코드 : " + witnessCode);

        return this.messageService.sendOne(new SingleMessageSendingRequest(message));
    }
}