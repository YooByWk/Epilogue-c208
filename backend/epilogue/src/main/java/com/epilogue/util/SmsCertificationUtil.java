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

    public SingleMessageSentResponse sendWillLink(String to, String deadName, String viewerName) {
        String applyLink = "http://j10c208.p.ssafy.io/witness";
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01066041442");
        message.setTo(to);
        message.setText("[E:pilogue] 유언 열람 안내\n\n안녕하세요. E:pilogue 입니다.\n" +
                viewerName + "님은 " + deadName + "님이 지정한 유언 열람인으로 " + deadName + "님의 유언 열람이 가능합니다.\n" +
                "아래의 유언 열람 링크에서 " + deadName + "님의 유언을 확인해주세요.\n" +
                "- 유언 열람 신청 링크 : " + applyLink);

        return this.messageService.sendOne(new SingleMessageSendingRequest(message));
    }

    // 단일 메시지 발송 예제
    public SingleMessageSentResponse sendSms(String to, String verificationCode) {
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01066041442");
        message.setTo(to);
        message.setText("[E:pilogue] 본인 확인 인증번호는 " + verificationCode + "입니다.");

        return this.messageService.sendOne(new SingleMessageSendingRequest(message));
    }

    public SingleMessageSentResponse sendWillApplyLink(String to, String deadName, String witnessName, String willCode) {
        String applyLink = "http://j10c208.p.ssafy.io/";
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01066041442");
        message.setTo(to);
        message.setText("[E:pilogue] 유언 열람 신청 안내\n\n안녕하세요. E:pilogue 입니다.\n" +
                witnessName + "님은 " + deadName + "님의 유언 생성 증인으로 추후" + deadName + "님이 별세하신 후 유언 열람 신청이 가능합니다.\n" +
                deadName + "님의 사망진단서와 아래의 인증코드를 지참하여 유언 열람 신청 폼에 입력하여 주시기 바랍니다.\n" +
                "검토 결과는 영업일 5일 이내에 해당 연락처로 전송됩니다.\n\n- 유언 열람 신청 링크 : " + applyLink + "\n- 인증코드 : " + willCode);

        return this.messageService.sendOne(new SingleMessageSendingRequest(message));
    }
}