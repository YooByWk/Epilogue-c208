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
        return entityManager.createQuery("SELECT mv FROM MemorialVideo mv JOIN FETCH mv.memorial WHERE mv.memorial.user.userSeq = :userSeq ORDER BY mv.writtenDate DESC", MemorialVideo.class)
                .setParameter("userSeq", userSeq)
                .getResultList();
    }
}
