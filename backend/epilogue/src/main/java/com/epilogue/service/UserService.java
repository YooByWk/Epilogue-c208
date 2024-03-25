package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.dto.request.user.JoinRequestDto;
import com.epilogue.dto.request.user.SmsCertificationRequest;
import com.epilogue.dto.request.user.UpdateInfoRequestDto;
import com.epilogue.dto.response.user.UserDTO;
import com.epilogue.repository.SmsCertificationRepository;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.util.SmsCertificationUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final SmsCertificationUtil smsUtil;
    private final SmsCertificationRepository smsCertificationRepository;

    @Transactional
    public void join(JoinRequestDto joinRequestDto) {
        User user = User.builder()
                .userId(joinRequestDto.getUserId())
                .password(bCryptPasswordEncoder.encode(joinRequestDto.getPassword()))
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

    public void updateUserInfo(String loginUserId, UpdateInfoRequestDto updateInfoRequestDto) {
        User findUser = userRepository.findByUserId(loginUserId);
        findUser.updateUserInfo(updateInfoRequestDto.getName(), updateInfoRequestDto.getMobile());
    }

    public void deleteMember(String loginUserId) {
        userRepository.delete(userRepository.findByUserId(loginUserId));
    }

    public void sendSms(SmsCertificationRequest requestDto) {
        String to = requestDto.getPhone();
        int randomNumber = (int) (Math.random() * 9000) + 1000;
        String certificationNumber = String.valueOf(randomNumber);
        smsUtil.sendSms(to, certificationNumber);
        smsCertificationRepository.createSmsCertification(to, certificationNumber);
    }

    public void verifySms(SmsCertificationRequest requestDto) {
        if (isVerify(requestDto)) {
            System.out.println("인증번호 틀림");
        }
        smsCertificationRepository.removeSmsCertification(requestDto.getPhone());
    }

    public boolean isVerify(SmsCertificationRequest requestDto) {
        return !(smsCertificationRepository.hasKey(requestDto.getPhone()) &&
                smsCertificationRepository.getSmsCertification(requestDto.getPhone())
                        .equals(requestDto.getCertificationNumber()));
    }

}
