package com.epilogue.repository.user;


import com.epilogue.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserRepository extends JpaRepository<User, Integer>, UserRepositoryCustom {
    Boolean existsByUserId(String userId);

    User findByUserId(String userId);

    User findByUserSeq(int userSeq);

    @Query("UPDATE User u SET u.password = :password WHERE u.userId = :loginUserId")
    void updatePassword(String loginUserId, String password);

    User findByNameAndBirth(String name, String birth);
}
