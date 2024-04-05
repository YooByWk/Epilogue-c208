package com.epilogue.repository.user;


import com.epilogue.domain.memorial.Memorial;
import com.epilogue.domain.user.User;
import com.epilogue.domain.user.UserStatus;
import com.epilogue.domain.will.Will;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Integer> {
    Boolean existsByUserId(String userId);

    User findByUserId(String userId);

    @Query("UPDATE User u SET u.password = :password WHERE u.userId = :loginUserId")
    @Transactional
    @Modifying
    void updatePassword(String loginUserId, String password);

    User findByNameAndBirth(String name, String birth);

    @Query("SELECT u FROM User u WHERE u.userStatus = :status")
    List<User> findByUserStatus(UserStatus status);

    User findByWill(Will will);
}
