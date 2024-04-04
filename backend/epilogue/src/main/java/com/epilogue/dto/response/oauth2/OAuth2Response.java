package com.epilogue.dto.response.oauth2;

public interface OAuth2Response {

    //제공자 (Ex. naver, google, ...)
    String getProvider();

    //제공자에서 발급해주는 아이디(번호)
    String getProviderId();

    //휴대폰번호
    String getMobile();

    //사용자 실명 (설정한 이름)
    String getName();

    //사용자 생일
    String getBirthday();

    //사용자 생년
    String getBirthyear();
}