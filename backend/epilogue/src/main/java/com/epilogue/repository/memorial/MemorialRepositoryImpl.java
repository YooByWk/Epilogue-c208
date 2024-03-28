package com.epilogue.repository.memorial;

import com.epilogue.domain.memorial.Memorial;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemorialRepositoryImpl implements MemorialRepositoryCustom {

    @Autowired
    EntityManager entityManager;

    @Override
    public List<Memorial> findAllByDate() {
        return entityManager.createQuery("SELECT m FROM Memorial m ORDER BY goneDate DESC", Memorial.class)
                .getResultList();
    }

//    @Override
//    public List<Memorial> findBySearchWord(String searchWord) {
//        return entityManager.createQuery("SELECT m FROM Memorial m WHERE m.user.name LIKE %:searchWord% OR m.graveName LIKE %:searchWord%", Memorial.class)
//                .setParameter("searchWord", searchWord)
//                .getResultList();
//    }

}
