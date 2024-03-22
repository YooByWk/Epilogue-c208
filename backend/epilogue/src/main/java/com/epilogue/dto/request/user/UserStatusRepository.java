package com.epilogue.dto.request.user;

import com.epilogue.domain.user.UserStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserStatusRepository extends JpaRepository<UserStatus, Integer> {
}
