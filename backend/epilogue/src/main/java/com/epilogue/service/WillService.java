package com.epilogue.service;

import com.epilogue.domain.will.Will;
import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.repository.will.WillRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class WillService {
    private final WillRepository willRepository;

    public void create(WillRequestDto willRequestDto) {
        Will will = Will.builder()
                .sustainCare(willRequestDto.isSustainCare())
                .funeralType(willRequestDto.getFuneralType())
                .graveType(willRequestDto.getGraveType())
                .organDonation(willRequestDto.isOrganDonation())
                .useMemorial(willRequestDto.isUseMemorial())
                .graveName(willRequestDto.getGraveName())
                .graveImage(willRequestDto.getGraveImage())
                .willDraftScript(willRequestDto.getWillDraftScript())
                .willFileName(willRequestDto.getWillFileName())
                .viewApplyLink(willRequestDto.getViewApplyLink())
                .willLink(willRequestDto.getWillLink())
                .build();

        willRepository.save(will);
    }
}
