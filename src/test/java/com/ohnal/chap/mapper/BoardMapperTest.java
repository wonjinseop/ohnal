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
    @DisplayName("댓글 3000개 작성하기")
    void writeReply() {
        // given
        int bno;
        String email = "user123@naver.com";
        String content = "";
        
        // when
        for (int i = 1; i <= 3000; i++) {
            
            bno = (int) (Math.random() * 40 + 1);
            content = "더미댓글" + i + "입니다.";
            
//            mapper.replySave(bno, email, content);
        }
        
    
        // then
    }
    
}