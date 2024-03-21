package com.epilogue.repository.memorial.favorite;

import com.epilogue.domain.memorial.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FavoriteRepository extends JpaRepository<Favorite, Integer> {

}
