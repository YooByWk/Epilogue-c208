package com.epilogue.repository.user;


import com.epilogue.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer>, UserRepositoryCustom {
    Boolean existsByUserId(String userId);
    User findByUserId(String userId);
    User findByUserSeq(int userSeq);
}
