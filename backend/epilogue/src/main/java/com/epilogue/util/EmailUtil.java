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

    public boolean sendWillApplyLink(String email, String name, String witnessCode) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true);

            String htmlContent = getWillApplyMessage(name, witnessCode);

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

    private String getWillApplyMessage(String name, String witnessCode) {
        String certificationMessage = "";
        certificationMessage += "<h1 style='text-align: center;'>[E:pilogue] 유언 열람 신청";
        certificationMessage += "<h3 style='text-align: center;'>" + name + "님의 유언 열람을 신청할 수 있습니다.<br>" + "유언 열람 신청 전, 사망진단서와 아래의 인증코드를 미리 준비해주세요.<br>" +
                "유언 열람 신청 링크 : http://j10c208.p.ssafy.io/<br>인증코드 : " + witnessCode + "</h3>";
        return certificationMessage;
    }
}
