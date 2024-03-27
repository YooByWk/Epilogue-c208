package com.epilogue.repository.will;

import com.epilogue.domain.will.Will;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface WillRepository extends JpaRepository<Will, Integer> {
//    @Transactional
//    void deleteByWillSeq(int willSeq);
}
