package com.epilogue.util;

import com.epilogue.domain.memorial.Memorial;
import com.epilogue.domain.user.User;
import com.epilogue.domain.user.UserStatus;
import com.epilogue.repository.memorial.MemorialRepository;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.service.MemorialService;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

//@Component
@RequiredArgsConstructor
public class ProductInitializer {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final MemorialRepository memorialRepository;

    @PostConstruct
    public void init() {
        // 더미 데이터 작성
        User user1 = User.builder()
                .name("한재현")
                .userId("ssafy")
                .password(bCryptPasswordEncoder.encode("1234"))
                .birth("980228")
                .mobile("01011111111")
                .userStatus(UserStatus.LIVE)
                .build();

        User user2 = User.builder()
                .name("김유나")
                .userId("yuna")
                .password(bCryptPasswordEncoder.encode("1234"))
                .birth("000921")
                .mobile("01022222222")
                .userStatus(UserStatus.LIVE)
                .build();


        Memorial memorial1 = Memorial.builder()
                .user(user1)
                .goneDate("2024-01-01")
                .graveName("jaehyeon")
                .graveImg("11")
                .build();

        Memorial memorial2 = Memorial.builder()
                .user(user2)
                .goneDate("2024-02-02")
                .graveName("yuna")
                .graveImg("22")
                .build();

        // 더미 데이터 저장
        userRepository.save(user1);
        userRepository.save(user2);
        memorialRepository.save(memorial1);
        memorialRepository.save(memorial2);
    }
}