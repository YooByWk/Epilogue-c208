package com.epilogue.repository.memorial.favorite;

import com.epilogue.domain.memorial.Favorite;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FavoriteRepositoryImpl implements FavoriteRepositoryCustom {

    @Autowired
    EntityManager entityManager;

    @Override
    public List<Favorite> findByUserId(String loginUserId) {
        return entityManager.createQuery("SELECT f FROM Favorite f WHERE f.user.userId = :loginUserId", Favorite.class)
                .setParameter("loginUserId", loginUserId)
                .getResultList();
    }

    @Override
    public List<Favorite> findByLoginUserIdAndMemorialSeq(String loginUserId, int memorialSeq) {
        return entityManager.createQuery("SELECT f FROM Favorite f WHERE f.user.userId = :loginUserId AND f.memorial.memorialSeq = :memorialSeq", Favorite.class)
                .setParameter("loginUserId", loginUserId)
                .setParameter("memorialSeq", memorialSeq)
                .getResultList();
    }

}
