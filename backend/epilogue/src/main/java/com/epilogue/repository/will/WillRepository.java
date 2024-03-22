package com.epilogue.repository.will;

import com.epilogue.domain.will.Will;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface WillRepository extends JpaRepository<Will, Integer> {
    void deleteByWillSeq(int willSeq);
}