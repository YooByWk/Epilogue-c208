package com.epilogue.repository.memorial.favorite;

import com.epilogue.domain.memorial.Favorite;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavoriteRepositoryCustom {

    public List<Favorite> findByUserId(String loginUserId);

}
