package com.epilogue.repository.memorial.photo;

import com.epilogue.domain.memorial.MemorialPhoto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemorialPhotoRepositoryCustom {
    public List<MemorialPhoto> find20ByUserSeq(int userSeq);

    public List<MemorialPhoto> findAllByUserSeq(int userSeq);

    public List<MemorialPhoto> find20ByMemorialSeq(int memorialSeq);

    public List<MemorialPhoto> find20ByMemorialSeqAndLastPhotoSeq(int memorialSeq, int lastPhotoSeq);

    public List<MemorialPhoto> findAllByMemorialSeq(int memorialSeq);

}
