package com.epilogue.repository.memorial.video;

import com.epilogue.domain.memorial.MemorialPhoto;
import com.epilogue.domain.memorial.MemorialVideo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemorialVideoRepositoryCustom {

    public List<MemorialVideo> findAllByUserSeq(int userSeq);

    public List<MemorialVideo> find20ByMemorialSeq(int memorialSeq);

    public List<MemorialVideo> find20ByMemorialSeqAndLastVideoSeq(int memorialSeq, int lastVideoSeq);

    public List<MemorialVideo> findAllByMemorialSeq(int memorialSeq);
}
