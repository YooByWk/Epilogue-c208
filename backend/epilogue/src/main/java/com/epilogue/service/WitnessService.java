package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.will.Will;
import com.epilogue.domain.witness.Witness;
import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.dto.request.witness.WitnessRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.will.WillRepository;
import com.epilogue.repository.witness.WitnessRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class WitnessService {
    private final WitnessRepository witnessRepository;
    private final WillRepository willRepository;
    private final UserRepository userRepository;

    public void create(int willSeq, WillRequestDto willRequestDto) {
        List<WitnessRequestDto> witnessList = willRequestDto.getWitnessList();

        for (WitnessRequestDto w : witnessList) {
            Witness witness = Witness.builder()
                    .will(willRepository.findById(willSeq).get())
                    .witnessName(w.getWitnessName())
                    .witnessEmail(w.getWitnessEmail())
                    .witnessPhone(w.getWitnessPhone())
                    .witnessCode(UUID.randomUUID().toString())
                    .build();

            witnessRepository.save(witness);
        }
    }
}
