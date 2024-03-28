package com.epilogue.repository.memorial;

import com.epilogue.domain.memorial.Memorial;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

public interface MemorialRepository extends JpaRepository<Memorial, Integer>, MemorialRepositoryCustom {

    @Query("SELECT m FROM Memorial m WHERE m.goneDate <= FUNCTION('TO_DATE', :dateStr, 'yyyy.MM.dd')")
    List<Memorial> findMemorialsOlderThanDate(String dateStr);

//    List<Memorial> findByUserNameLike(String keyword);

//    List<Memorial> findByUserNameIsContaining(String keyword);

}
