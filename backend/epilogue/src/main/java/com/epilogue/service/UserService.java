package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.user.UserStatus;
import com.epilogue.dto.request.user.*;
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
                .userStatus(UserStatus.LIVE)
                .build();

        userRepository.save(user);
    }

    public Boolean check(IdCheckRequestDto idCheckRequestDto) {
        return userRepository.existsByUserId(idCheckRequestDto.getUserId());
    }

    public void updatePassword(String loginUserId, UpdatePasswordRequestDto updatePasswordRequestDto) {
        userRepository.updatePassword(loginUserId, updatePasswordRequestDto.getPassword());
    }

    public UserDTO userInfo(String loginUserId) {
        User findUser = userRepository.findByUserId(loginUserId);
        return new UserDTO(findUser);
    }

    @Transactional
    public void updateUserInfo(String loginUserId, UpdateInfoRequestDto updateInfoRequestDto) {
        User findUser = userRepository.findByUserId(loginUserId);
        findUser.updateUserInfo(updateInfoRequestDto.getName(), updateInfoRequestDto.getMobile());
    }

    public void deleteMember(String loginUserId) {
        userRepository.delete(userRepository.findByUserId(loginUserId));
    }

    public void sendSms(SmsCertificationRequestDto requestDto) {
        String to = requestDto.getPhone();
        int randomNumber = (int) (Math.random() * 9000) + 1000;
        String certificationNumber = String.valueOf(randomNumber);
        smsUtil.sendSms(to, certificationNumber);
        smsCertificationRepository.createSmsCertification(to, certificationNumber);
    }

    public boolean verifySms(SmsCertificationRequestDto smsCertificationRequestDto) {
        if (isVerify(smsCertificationRequestDto)) {
            return false;
        }
        smsCertificationRepository.removeSmsCertification(smsCertificationRequestDto.getPhone());
        return true;
    }

    public boolean isVerify(SmsCertificationRequestDto requestDto) {
        return !(smsCertificationRepository.hasKey(requestDto.getPhone()) &&
                smsCertificationRepository.getSmsCertification(requestDto.getPhone())
                        .equals(requestDto.getCertificationNumber()));
    }

}
