package com.epilogue.repository.memorial;

import com.epilogue.domain.memorial.Memorial;
import com.epilogue.domain.user.User;
import com.epilogue.domain.will.Will;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public interface MemorialRepository extends JpaRepository<Memorial, Integer>, MemorialRepositoryCustom {

    @Query("SELECT m FROM Memorial m WHERE m.createdDate <= :currentTimestamp")
    List<Memorial> findMemorialsOlderThanDate(Timestamp currentTimestamp);

    @Query("""
            SELECT m FROM Memorial m
            WHERE
                m.user.name LIKE CONCAT('%', :searchWord, '%')
                OR m.graveName LIKE CONCAT('%', :searchWord, '%')""")
    List<Memorial> findMemorialsByGraveNameOrUserName(String searchWord);

    Memorial findMemorialByUser(User user);
}
