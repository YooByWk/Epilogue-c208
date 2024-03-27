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
    public List<Favorite> findListById(int userSeq) {
        return entityManager.createQuery("SELECT f FROM Favorite f JOIN FETCH f.memorial WHERE f.memorial.user.userSeq = :userSeq ORDER BY f.memorial.goneDate DESC", Favorite.class)
                .setParameter("userSeq", userSeq)
                .getResultList();
    }

    @Override
    public List<Favorite> findByUserId(String loginUserId) {
        return entityManager.createQuery("SELECT f FROM Favorite f WHERE f.user.userId = :loginUserId", Favorite.class)
                .setParameter("loginUserId", loginUserId)
                .getResultList();
    }

}
