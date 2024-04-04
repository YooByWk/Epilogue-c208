package com.epilogue.repository.memorial.letter;

import com.epilogue.domain.memorial.MemorialLetter;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemorialLetterRepositoryCustom {

    public List<MemorialLetter> findAllByUserSeq(int userSeq);

    public List<MemorialLetter> findAllByMemorialSeq(int memorialSeq);

    public List<MemorialLetter> find20ByMemorialSeq(int memorialSeq);

    public List<MemorialLetter> find20ByMemorialSeqAndLastLetterSeq(int memorialSeq, int lastLetterSeq);

}
