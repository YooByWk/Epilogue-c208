package com.epilogue.repository.user;

import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepositoryCustom {

    void updateRefreshToken(String userId, String refreshToken);

    String getRefreshTokenByUserId(String userId);
}
