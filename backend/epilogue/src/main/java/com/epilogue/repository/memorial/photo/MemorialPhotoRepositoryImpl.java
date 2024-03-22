package com.epilogue.repository.memorial.photo;

import com.epilogue.domain.memorial.MemorialPhoto;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemorialPhotoRepositoryImpl implements MemorialPhotoRepositoryCustom {

    @Autowired
    EntityManager entityManager;

    @Override
    public List<MemorialPhoto> findAllByUserSeq(int userSeq) {
        return entityManager.createQuery("SELECT mp FROM MemorialPhoto mp JOIN FETCH mp.memorial WHERE mp.memorial.user.userSeq = :userSeq", MemorialPhoto.class)
                .setParameter("userSeq", userSeq)
                .getResultList();
    }
}
