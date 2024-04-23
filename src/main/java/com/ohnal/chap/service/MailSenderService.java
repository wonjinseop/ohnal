package com.ohnal.chap.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import java.util.Random;

@Component
@RequiredArgsConstructor
@Slf4j
public class MailSenderService {


     private final JavaMailSender mailSender;

    private int makeRandomNumber(){
        Random r=new Random();
        int checkNum= r.nextInt(888888)+111111;
        return checkNum;
    }

    public String joinEmail(String email){
        int authNum= makeRandomNumber();
        log.info("메일인증번호: {}",String.valueOf(authNum));

        String setFrom="ohnal2024@gmail.com";
        String toMail=email;
        String title="oh-nal 회원 가입 인증 이메일 입니다.";
        String content = "회원가입을 신청해 주셔서 감사합니다."+
                "<br><br><br>"+
                "인증 번호는 <strong>"+authNum+"</strong>입니다."+
                "인증 번호를 인증번호 확인란에 기입해 주세요.";

        mailSend(setFrom,toMail,title,content);
        return Integer.toString(authNum);
    }

    private void mailSend(String setFrom, String toMail, String title, String content) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, false, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            // true -> html 형식으로 전송, 값을 안주면 단순 텍스트로만 전달.
            helper.setText(content, true);


            log.info(String.valueOf(helper));

            mailSender.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }


    }

}
