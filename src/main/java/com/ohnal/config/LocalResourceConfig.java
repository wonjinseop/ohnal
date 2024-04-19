package com.ohnal.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 브라우저에서는 직접 로컬 경로를 지목해서 데이터를 가져오지 못합니다.
// 로컬에 저장된 이미지 경로를 웹 브라우저에서 불러올 수 있게 URL을 만드는 설정
@Configuration
public class LocalResourceConfig implements WebMvcConfigurer {
    
    private String rootPath = "C:/myWorkSpace/upload/";
    
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        
        /*
            하드디스크에 저장된 rootPath 아래의 파일은
            http url에서 /local/파일경로명 -> 이렇게 요청이 들어오면 접근할 수 있게 하겠다.
        */
        registry
                .addResourceHandler("/local/**")
                .addResourceLocations("file:" + rootPath);
        
    }
}
