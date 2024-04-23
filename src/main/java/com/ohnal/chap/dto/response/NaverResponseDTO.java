//package com.ohnal.chap.dto.response;
//
//import com.fasterxml.jackson.annotation.JsonProperty;
//import lombok.*;
//
//@Getter
//@Setter
//@ToString
//@EqualsAndHashCode
//@NoArgsConstructor
//@AllArgsConstructor
//public class NaverResponseDTO {
//    private String Adress;
//    private String NickName;
//    private String ProfileImg;
//
//    @JsonProperty("Naver_account")
//    private NaverAccount account;
//    private String nickName;
//    private String profileImg;
//    private String gender;
//
//    private Properties properties;
//    @Setter @Getter @ToString
//    public static class Properties {
//
//        private String nickname;
//        @JsonProperty("profile_image")
//        private String profileImage;
//
//
//    }
//
//    @Getter @Setter @ToString
//    public static class NaverAccount {
//        private String email;
//    }
//
//}