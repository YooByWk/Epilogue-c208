package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.dto.request.user.JoinRequestDto;
import com.epilogue.dto.response.user.UserDTO;
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
    private final JWTUtil jwtUtil;

    @Transactional
    public void join(JoinRequestDto joinRequestDto) {
        User user = User.builder()
                .userId(joinRequestDto.getUserId())
                .password(joinRequestDto.getPassword())
                .name(joinRequestDto.getName())
                .mobile(joinRequestDto.getMobile())
                .birth(joinRequestDto.getBirth())
                .build();

        userRepository.save(user);
    }

    public Boolean check(String userId) {
        return userRepository.existsByUserId(userId);
    }

    public void updatePassword(String loginUserId, String password) {
        userRepository.updatePassword(loginUserId, password);
    }

    public UserDTO userInfo(String loginUserId) {
        User findUser = userRepository.findByUserId(loginUserId);
        return new UserDTO(findUser);
    }

}
