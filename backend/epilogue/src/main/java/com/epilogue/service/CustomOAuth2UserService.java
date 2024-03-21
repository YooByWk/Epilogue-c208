package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.dto.response.oauth2.NaverResponse;
import com.epilogue.dto.response.oauth2.OAuth2Response;
import com.epilogue.dto.response.user.UserDTO;
import com.epilogue.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
    private final UserRepository userRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        System.out.println("!!!!!!!!!!!!!!!!!!!!!!");
        OAuth2User oAuth2User = super.loadUser(userRequest);
        System.out.println(oAuth2User);

        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        OAuth2Response oAuth2Response;
        if (registrationId.equals("naver")) {

            oAuth2Response = new NaverResponse(oAuth2User.getAttributes());
//        } else if (registrationId.equals("google")) {

//            oAuth2Response = new GoogleResponse(oAuth2User.getAttributes());
        } else {

            return null;
        }
        String username = oAuth2Response.getProvider() + " " + oAuth2Response.getProviderId();
        User existData = userRepository.findByUserId(username);

        if (existData == null) {


            User user = User.builder()
                    .name(oAuth2Response.getName())
                    .password("1")
                    .userId(oAuth2Response.getProviderId())
                    .mobile(oAuth2Response.getMobile())
                    .birth(oAuth2Response.getBirthyear() + oAuth2Response.getBirthday())
                    .build();

            userRepository.save(user);

            UserDTO userDTO = new UserDTO();
            userDTO.setName(oAuth2Response.getName());
            userDTO.setUserId(oAuth2Response.getProviderId());
            return new CustomOAuth2User(userDTO);
        } else {

            existData.setName(oAuth2Response.getName());

            userRepository.save(existData);

            UserDTO userDTO = new UserDTO();
            userDTO.setName(oAuth2Response.getName());
            userDTO.setUserId(oAuth2Response.getProviderId());

            return new CustomOAuth2User(userDTO);
        }
    }
}