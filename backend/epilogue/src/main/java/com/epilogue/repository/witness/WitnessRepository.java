package com.epilogue.repository.witness;

import com.epilogue.domain.witness.Witness;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WitnessRepository extends JpaRepository<Witness, Integer> {
    Witness findByWitnessNameAndWitnessCode(String witnessName, String witnessCode);
    @Transactional
    void deleteAllByWillWillSeq(int willSeq);
}