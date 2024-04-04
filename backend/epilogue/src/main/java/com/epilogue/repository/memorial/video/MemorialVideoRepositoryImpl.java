package com.epilogue.repository.memorial.video;

import com.epilogue.domain.memorial.MemorialVideo;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class MemorialVideoRepositoryImpl implements MemorialVideoRepositoryCustom {

    @Autowired
    EntityManager entityManager;

    @Override
    public List<MemorialVideo> findAllByUserSeq(int userSeq) {
//        return entityManager.createQuery("SELECT mv FROM MemorialVideo mv JOIN FETCH mv.memorial WHERE mv.memorial.user.userSeq = :userSeq ORDER BY mv.writtenDate DESC", MemorialVideo.class)
        return entityManager.createQuery("SELECT mv FROM MemorialVideo mv JOIN FETCH mv.memorial WHERE mv.memorial.user.userSeq = :userSeq", MemorialVideo.class)
                .setParameter("userSeq", userSeq)
                .getResultList();
    }

    @Override
    public List<MemorialVideo> find20ByMemorialSeq(int memorialSeq) {
        return entityManager.createQuery("SELECT mv FROM MemorialVideo mv WHERE mv.memorial.memorialSeq = :memorialSeq ORDER BY mv.writtenDate DESC LIMIT 20", MemorialVideo.class)
                .setParameter("memorialSeq", memorialSeq)
                .getResultList();
    }

    @Override
    public List<MemorialVideo> find20ByMemorialSeqAndLastVideoSeq(int memorialSeq, int lastVideoSeq) {
        return entityManager.createQuery("SELECT mv FROM MemorialVideo mv WHERE mv.memorial.memorialSeq = :memorialSeq AND mv.memorialVideoSeq < :lastVideoSeq ORDER BY mv.writtenDate DESC LIMIT 20", MemorialVideo.class)
                .setParameter("memorialSeq", memorialSeq)
                .setParameter("lastVideoSeq", lastVideoSeq)
                .getResultList();
    }

    @Override
    public List<MemorialVideo> findAllByMemorialSeq(int memorialSeq) {
        return entityManager.createQuery("SELECT mv FROM MemorialVideo mv WHERE mv.memorial.memorialSeq = :memorialSeq", MemorialVideo.class)
                .setParameter("memorialSeq", memorialSeq)
                .getResultList();
    }
}
