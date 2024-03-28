package com.epilogue.util;

import com.epilogue.domain.memorial.Memorial;
import com.epilogue.domain.user.User;
import com.epilogue.domain.user.UserStatus;
import com.epilogue.repository.memorial.MemorialRepository;
import com.epilogue.repository.user.UserRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

//@Component
@RequiredArgsConstructor
public class ProductInitializer {

    private final UserRepository userRepository;
    private final MemorialRepository memorialRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostConstruct
    public void init() {
        // 더미 데이터 작성
        User user1 = User.builder()
                .name("한재현1")
                .userId("ssafy1")
                .password(bCryptPasswordEncoder.encode("1234"))
                .birth("980228")
                .mobile("01012345678")
                .userStatus(UserStatus.LIVE)
                .build();

        User user2 = User.builder()
                .name("한재현2")
                .userId("ssafy2")
                .password(bCryptPasswordEncoder.encode("1234"))
                .birth("980228")
                .mobile("01012345678")
                .userStatus(UserStatus.LIVE)
                .build();

        User user3 = User.builder()
                .name("김유나")
                .userId("ssafy3")
                .password(bCryptPasswordEncoder.encode("1234"))
                .birth("980228")
                .mobile("01012345678")
                .userStatus(UserStatus.LIVE)
                .build();

        Memorial memorial1 = Memorial.builder()
                .memorialSeq(1)
                .user(user1)
                .goneDate("2024.01.01")
                .graveName("김유나")
                .graveImg("img1")
                .build();

        Memorial memorial2 = Memorial.builder()
                .memorialSeq(2)
                .user(user2)
                .goneDate("2024.01.01")
                .graveName("한재현2")
                .graveImg("img1")
                .build();

        Memorial memorial3 = Memorial.builder()
                .memorialSeq(3)
                .user(user3)
                .goneDate("2024.01.01")
                .graveName("유나")
                .graveImg("img1")
                .build();

        // 더미 데이터 저장
        userRepository.save(user1);
        userRepository.save(user2);
        userRepository.save(user3);

        memorialRepository.save(memorial1);
        memorialRepository.save(memorial2);
        memorialRepository.save(memorial3);
    }
}