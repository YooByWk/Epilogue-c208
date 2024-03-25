package com.epilogue.repository.memorial.video;

import com.epilogue.domain.memorial.MemorialVideo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemorialVideoRepositoryCustom {

    List<MemorialVideo> findAllByUserSeq(int userSeq);

}
