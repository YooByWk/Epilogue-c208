package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.will.Will;
import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.will.WillRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;

import java.security.Principal;

@Service
@RequiredArgsConstructor
public class WillService {
    private final WillRepository willRepository;
    private final UserRepository userRepository;

    public Will create(WillRequestDto willRequestDto, Principal principal) {
        Will will = Will.builder()
                .sustainCare(willRequestDto.isSustainCare())
                .funeralType(willRequestDto.getFuneralType())
                .graveType(willRequestDto.getGraveType())
                .organDonation(willRequestDto.isOrganDonation())
                .useMemorial(willRequestDto.isUseMemorial())
                .graveName(willRequestDto.getGraveName())
                .graveImage(willRequestDto.getGraveImage())
                .willFileName(willRequestDto.getWillFileName())
                .viewApplyLink(willRequestDto.getViewApplyLink())
                .willLink(willRequestDto.getWillLink())
                .build();

        willRepository.save(will);

        // 회원에 유언 insert
        User user = userRepository.findByUserId(principal.getName());
        user.updateWill(will);

        return will;
    }

    public void viewMyWill(Principal principal) {
        String loginUserId = principal.getName();

        // S3에서 녹음 파일 가져오기

    }

    public void deleteMyWill(Principal principal) {
        String loginUserId = principal.getName();

        // S3에서 유언 파일 삭제
        // 블록체인에서 유언 파일 url 삭제
        // DB에서 유언 삭제
        User user = userRepository.findByUserId(loginUserId);
        Will will = user.getWill();
        willRepository.deleteByWillSeq(will.getWillSeq());
    }
}
