package com.epilogue.repository.memorial.letter;

import com.epilogue.domain.memorial.MemorialLetter;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemorialLetterRepositoryCustom {

    List<MemorialLetter> findAllByUserSeq(int userSeq);

}
