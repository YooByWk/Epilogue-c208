package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.dto.request.user.JoinRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.util.jwt.JWTUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final JWTUtil jwtUtil;
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Transactional
    public void join(JoinRequestDto joinRequestDto) {
        User user = User.builder()
                .userId(joinRequestDto.getUserId())
                .password(bCryptPasswordEncoder.encode(joinRequestDto.getPassword()))
                .name(joinRequestDto.getName())
                .phone(joinRequestDto.getPhone())
                .birth(joinRequestDto.getBirth())
                .build();

        userRepository.save(user);
    }


}
