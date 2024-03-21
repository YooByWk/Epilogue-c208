package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.will.Will;
import com.epilogue.domain.witness.Witness;
import com.epilogue.dto.request.will.WillApplyRequestDto;
import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.will.WillRepository;
import com.epilogue.repository.witness.WitnessRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;

import java.security.Principal;

@Service
@RequiredArgsConstructor
public class WillService {
    private final WillRepository willRepository;
    private final UserRepository userRepository;
    private final WitnessRepository witnessRepository;

    public Will create(WillRequestDto willRequestDto, Principal principal) {
        Will will = Will.builder()
                .sustainCare(willRequestDto.isSustainCare())
                .funeralType(willRequestDto.getFuneralType())
                .graveType(willRequestDto.getGraveType())
                .organDonation(willRequestDto.isOrganDonation())
                .useMemorial(willRequestDto.isUseMemorial())
                .graveName(willRequestDto.getGraveName())
                .graveImage(willRequestDto.getGraveImage())
                .willFileAddress(willRequestDto.getWillFileAddress())
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

    public boolean applyWill(WillApplyRequestDto willApplyRequestDto) {
        // 고인 이름, 고인 생년월일, 증인 이름, 증인 코드 일치 검사
        String deadName = willApplyRequestDto.getDeadName();
        String deadBirth = willApplyRequestDto.getDeadBirth();
        String witnessName = willApplyRequestDto.getWitnessName();
        String witnessCode = willApplyRequestDto.getWitnessCode();

        User user = userRepository.findByNameAndBirth(deadName, deadBirth);
        if (user == null) return false;

        Witness witness = witnessRepository.findByWitnessNameAndWitnessCode(witnessName, witnessCode);
        if (witness == null) return false;

        int deadWillSeq = user.getWill().getWillSeq();
        int witnessWillSeq = witness.getWill().getWillSeq();

        if (deadWillSeq == witnessWillSeq) return true;
        else return false;
    }
}
