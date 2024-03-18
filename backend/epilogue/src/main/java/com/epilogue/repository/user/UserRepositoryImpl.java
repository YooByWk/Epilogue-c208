package com.epilogue.repository.user;

import com.epilogue.domain.user.User;
import jakarta.persistence.EntityManager;
import org.springframework.transaction.annotation.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
@Slf4j
public class UserRepositoryImpl implements UserRepositoryCustom {

    @Autowired
    EntityManager entityManager;

    @Override
    public void updateRefreshToken(String userId, String refreshToken) {
        try {
            User findUser = entityManager.createQuery("SELECT u FROM User u WHERE u.userId = :userId", User.class)
                    .setParameter("userId", userId)
                    .getSingleResult();

            // refreshtoken 값 업데이트
            findUser.setRefreshToken(refreshToken);

            // 엔터티 저장
            entityManager.persist(findUser);
        } catch (Exception exception) {
            log.error(exception.getMessage());
        }
    }

    @Override
    public String getRefreshTokenByUserId(String userId) {
        return entityManager.createQuery("SELECT u FROM User u WHERE u.userId = :userId", User.class).
                setParameter("userId", userId)
                .getSingleResult()
                .getRefreshToken();
    }
}