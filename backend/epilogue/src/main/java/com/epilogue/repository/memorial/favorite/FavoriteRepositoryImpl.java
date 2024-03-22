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
        return entityManager.createQuery("SELECT f FROM Favorite f WHERE f.userSeq = :userSeq", Favorite.class)
                .setParameter("userSeq", userSeq)
                .getResultList();
    }

}