package com.epilogue.repository.memorial.photo;

import com.epilogue.domain.memorial.MemorialPhoto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemorialPhotoRepositoryCustom {
    public List<MemorialPhoto> findAllByUserSeq(int userSeq);
}
