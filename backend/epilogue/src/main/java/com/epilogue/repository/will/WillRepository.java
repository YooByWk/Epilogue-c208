package com.epilogue.repository.will;

import com.epilogue.domain.will.Will;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface WillRepository extends JpaRepository<Will, Integer> {
    void deleteByWillSeq(int willSeq);

    @Modifying
    @Transactional
    @Query("UPDATE Will w SET w.willFileAddress = :willFileAddress WHERE w.willSeq = :willSeq")
    void updateWillFileAddress(int willSeq, String willFileAddress);
}
