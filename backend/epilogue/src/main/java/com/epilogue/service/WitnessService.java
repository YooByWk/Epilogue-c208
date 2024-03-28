package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.will.Will;
import com.epilogue.domain.witness.Witness;
import com.epilogue.dto.request.witness.WitnessRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.will.WillRepository;
import com.epilogue.repository.witness.WitnessRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class WitnessService {
    private final WitnessRepository witnessRepository;
    private final WillRepository willRepository;
    private final UserRepository userRepository;

    @Transactional
    public void saveWitness(Will will, List<WitnessRequestDto> witnessList, Principal principal) {
        for (WitnessRequestDto w : witnessList) {
            Witness witness = Witness.builder()
                    .will(willRepository.findById(will.getWillSeq()).get())
                    .witnessName(w.getWitnessName())
                    .witnessEmail(w.getWitnessEmail())
                    .witnessMobile(w.getWitnessMobile())
                    .build();

            will.updateWillCode(UUID.randomUUID().toString());
            witnessRepository.save(witness);
        }

        // 회원에 유언 insert
        User user = userRepository.findByUserId(principal.getName());
        user.updateWill(will);
    }
}
