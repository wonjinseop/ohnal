package com.ohnal.chap.mapper;

import com.ohnal.chap.entity.Reply;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class BoardMapperTest {
    
    @Autowired
    BoardMapper mapper;
    
    @Test
    @DisplayName("댓글 10000개 작성하기")
    void writeReply() {
        // given
        int bno;
        String email = "user123@naver.com";
        String content = "";
        String user = "user";
        
        Reply reply = new Reply();
        reply.setEmail(email);
        reply.setNickname(user);
        
        // when
        for (int i = 1; i <= 10000; i++) {
            
            bno = (int) (Math.random() * 40 + 1);
            content = "더미댓글" + i + "입니다.";
            
            
            reply.setBno(bno);
            reply.setContent(content);
            
            mapper.updateCount(bno, "replies");
            
            mapper.replySave(reply);
        }
        
        
    
        // then
    }
    
    
    
}