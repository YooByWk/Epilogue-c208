package com.epilogue.util;

import com.epilogue.domain.user.User;
import com.epilogue.domain.user.UserStatus;
import com.epilogue.repository.user.UserRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProductInitializer {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostConstruct
    public void init() {
        // 더미 데이터 작성
        User user = User.builder()
                .name("한재현")
                .userId("ssafy")
                .password(bCryptPasswordEncoder.encode("1234"))
                .birth("980228")
                .mobile("01012345678")
                .userStatus(UserStatus.LIVE)
                .build();


        // 더미 데이터 저장
        userRepository.save(user);
    }
}