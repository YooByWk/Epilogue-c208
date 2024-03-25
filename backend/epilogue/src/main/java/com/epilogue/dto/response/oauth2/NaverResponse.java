package com.epilogue.dto.response.oauth2;

import java.util.Map;

public class NaverResponse implements OAuth2Response {

    private final Map<String, Object> attribute;

    public NaverResponse(Map<String, Object> attribute) {

        this.attribute = (Map<String, Object>) attribute.get("response");
    }

    @Override
    public String getProvider() {

        return "naver";
    }

    @Override
    public String getProviderId() {

        return attribute.get("id").toString();
    }

    @Override
    public String getMobile() {

        return attribute.get("mobile").toString();
    }

    @Override
    public String getName() {
        return attribute.get("userId").toString();
    }

    @Override
    public String getBirthday() {
        return attribute.get("birthday").toString();
    }

    @Override
    public String getBirthyear() {
        return attribute.get("birthyear").toString();
    }
}