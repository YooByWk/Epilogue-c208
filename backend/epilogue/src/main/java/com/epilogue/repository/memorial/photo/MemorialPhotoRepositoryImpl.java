package com.epilogue.repository.memorial.photo;

import com.epilogue.domain.memorial.Memorial;
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
    public List<MemorialPhoto> find20ByUserSeq(int userSeq) {
        return entityManager.createQuery("SELECT mp FROM MemorialPhoto mp JOIN FETCH mp.memorial WHERE mp.memorial.user.userSeq = :userSeq ORDER BY mp.writtenDate DESC LIMIT 20", MemorialPhoto.class)
                .setParameter("userSeq", userSeq)
                .getResultList();
    }

    @Override
    public List<MemorialPhoto> findAllByUserSeq(int userSeq) {
        return entityManager.createQuery("SELECT mp FROM MemorialPhoto mp JOIN FETCH mp.memorial WHERE mp.memorial.user.userSeq = :userSeq", MemorialPhoto.class)
                .setParameter("userSeq", userSeq)
                .getResultList();
    }

    @Override
    public List<MemorialPhoto> find20ByMemorialSeq(int memorialSeq) {
        return entityManager.createQuery("SELECT mp FROM MemorialPhoto mp WHERE mp.memorial.memorialSeq = :memorialSeq ORDER BY mp.writtenDate DESC LIMIT 20", MemorialPhoto.class)
                .setParameter("memorialSeq", memorialSeq)
                .getResultList();
    }

    @Override
    public List<MemorialPhoto> find20ByMemorialSeqAndLastPhotoSeq(int memorialSeq, int lastPhotoSeq) {
        return entityManager.createQuery("SELECT mp FROM MemorialPhoto mp WHERE mp.memorial.memorialSeq = :memorialSeq AND mp.memorialPhotoSeq < :lastPhotoSeq ORDER BY mp.writtenDate DESC LIMIT 20", MemorialPhoto.class)
                .setParameter("memorialSeq", memorialSeq)
                .setParameter("lastPhotoSeq", lastPhotoSeq)
                .getResultList();
    }

    @Override
    public List<MemorialPhoto> findAllByMemorialSeq(int memorialSeq) {
        return entityManager.createQuery("SELECT mp FROM MemorialPhoto mp WHERE mp.memorial.memorialSeq = :memorialSeq", MemorialPhoto.class)
                .setParameter("memorialSeq", memorialSeq)
                .getResultList();
    }

}
