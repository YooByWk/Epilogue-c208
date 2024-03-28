package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.will.Will;
import com.epilogue.domain.witness.Witness;
import com.epilogue.dto.request.will.WillAdditionalRequestDto;
import com.epilogue.dto.request.will.WillApplyRequestDto;
import com.epilogue.dto.request.will.WillMemorialRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.viewer.ViewerRepository;
import com.epilogue.repository.will.WillRepository;
import com.epilogue.repository.witness.WitnessRepository;
import com.epilogue.util.EmailUtil;
import com.epilogue.util.SmsCertificationUtil;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.security.Principal;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class WillService {
    private final WillRepository willRepository;
    private final UserRepository userRepository;
    private final WitnessRepository witnessRepository;
    private final AwsS3Service awsS3Service;
    private final ViewerRepository viewerRepository;

    private final SmsCertificationUtil smsUtil;
    private final EmailUtil emailUtil;

    public void saveWill(Will will) {
        willRepository.save(will);
    }

    @Transactional
    public void saveMemorial(WillMemorialRequestDto willMemorialRequestDto, Principal principal) {
        User user = userRepository.findByUserId(principal.getName());
        Will will = user.getWill();

        will.updateMemorial(willMemorialRequestDto.getUseMemorial(), willMemorialRequestDto.getGraveName());
    }

    @Transactional
    public void saveAdditionalInformation(WillAdditionalRequestDto willAdditionalRequestDto, Principal principal) {
        User user = userRepository.findByUserId(principal.getName());
        Will will = willRepository.findById(user.getWill().getWillSeq()).get();

        will.updateAdditionalInformation(willAdditionalRequestDto.getSustainCare(), willAdditionalRequestDto.getFuneralType(), willAdditionalRequestDto.getGraveType(), willAdditionalRequestDto.getOrganDonation());
    }

    public void sendWillApplyLink(Principal principal) {
        User user = userRepository.findByUserId(principal.getName());
        List<Witness> witnessList = witnessRepository.findAllByWillWillSeq(user.getWill().getWillSeq());

        // 휴대폰 문자로 유언 열람 신청 링크 및 인증코드 전송
        for (Witness w : witnessList) {
            if (w.getWitnessMobile() == null) continue;
            smsUtil.sendWillApplyLink(w.getWitnessMobile(), user.getName(), w.getWitnessCode());
        }

        // 이메일로 유언 열람 신청 링크 및 인증코드 전송
        for (Witness w : witnessList) {
            if (w.getWitnessEmail() == null) continue;
            emailUtil.sendWillApplyLink(w.getWitnessEmail(), user.getName(), w.getWitnessCode());
        }
    }

    public String viewMyWill(Principal principal) {
        String loginUserId = principal.getName();
        Will will = userRepository.findByUserId(loginUserId).getWill();

        // S3에서 녹음 파일 가져오기
        return awsS3Service.getWillFromS3(will.getWillFileAddress());
    }

    public void deleteMyWill(Principal principal) throws MalformedURLException, UnsupportedEncodingException {
        String loginUserId = principal.getName();

        // S3에서 유언 파일 삭제
        awsS3Service.deleteFromS3(principal);

        // 블록체인에서 유언 파일 url 삭제

        // DB에서 유언 삭제
        User user = userRepository.findByUserId(loginUserId);
        Will will = user.getWill();

        witnessRepository.deleteAllByWillWillSeq(will.getWillSeq());
        viewerRepository.deleteAllByWillWillSeq(will.getWillSeq());
        user.updateWillNull();
        willRepository.delete(will);

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
