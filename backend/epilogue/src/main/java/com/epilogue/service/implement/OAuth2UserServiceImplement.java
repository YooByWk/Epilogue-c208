package com.epilogue.service.implement;

import com.epilogue.domain.user.User;
import com.epilogue.domain.auth.CustomOAuth2User;
import com.epilogue.repository.user.UserRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class OAuth2UserServiceImplement extends DefaultOAuth2UserService {

    private final UserRepository userRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest request) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(request);
        String oauthClientName = request.getClientRegistration().getClientName();

        try {
            new ObjectMapper().writeValueAsString(oAuth2User.getAttributes());
        } catch (JsonProcessingException exception) {
            log.error(exception.getMessage());
        }

        User user = null;
        String userId = null;
        String name = null;
        String phone = null;
        String birth = null;

        if (oauthClientName.equals("kakao")) {
            Map<String, Object> maps = oAuth2User.getAttributes();
            userId = "kakao_" + maps.get("id");

            Map<Object, Object> kakaoAccount = (Map<Object, Object>) maps.get("kakao_account");
            name = kakaoAccount.get("name") + "";
            phone =  "0" + ((String) kakaoAccount
                    .get("phone_number"))
                    .substring(4, 16)
                    .replace("-", "");

            birth = kakaoAccount.get("birthyear") + "" + kakaoAccount.get("birthday");

            user = new User(userId, name, phone, birth);
        }

        if (oauthClientName.equals("naver")) {
            Map<String, String> responseMap = (Map<String, String>) oAuth2User.getAttributes().get("response");
            userId = "naver_" + responseMap.get("id");
            name = responseMap.get("name");
            phone = responseMap.get("mobile").replace("-", "");
            birth = responseMap.get("birthyear") + responseMap.get("birthday").substring(0, 2) + responseMap.get("birthday").substring(3, 5);
            user = new User(userId, name, phone, birth);
        }

        assert user != null;
        userRepository.save(user);
        return new CustomOAuth2User(userId);
    }
}