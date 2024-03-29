package com.epilogue.util;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class EmailUtil {

    private final JavaMailSender javaMailSender;

    private final String SUBJECT = "[E:pilogue] 유언 열람 신청 메일입니다.";

    public boolean sendWillApplyLink(String email, String deadName, String witnessName, String willCode) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true);

            String htmlContent = getWillApplyMessage(deadName, witnessName, willCode);

            messageHelper.setTo(email);
            messageHelper.setSubject(SUBJECT);
            messageHelper.setText(htmlContent, true);

            javaMailSender.send(message);
        } catch (MessagingException exception) {
            log.error(exception.getMessage());
            return false;
        }

        return true;
    }

    private String getWillApplyMessage(String deadName, String witnessName, String willCode) {
        String certificationMessage = "";
        String applyLink = "http://j10c208.p.ssafy.io/";
        certificationMessage += "<h1 style='text-align: center;'>[E:pilogue] 유언 열람 신청 안내";
        certificationMessage += "<h3 style='text-align: center;'>안녕하세요. E:pilogue 입니다.<br>" +
                witnessName + "님은 " + deadName + "님의 유언 생성 증인으로 추후 " + deadName + "님이 별세하신 후 유언 열람 신청이 가능합니다.<br>" +
                deadName + "님의 사망진단서와 아래의 인증코드를 지참하여 유언 열람 신청 폼에 입력하여 주시기 바랍니다.<br>" +
                "검토 결과는 영업일 5일 이내에 해당 연락처로 전송됩니다.<br><br>- 유언 열람 신청 링크 : " + applyLink + "<br>- 인증코드 : " + willCode + "</h3>";
        return certificationMessage;
    }
}
