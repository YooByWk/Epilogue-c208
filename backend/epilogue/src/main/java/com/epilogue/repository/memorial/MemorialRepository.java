package com.epilogue.repository.memorial;

import com.epilogue.domain.memorial.Memorial;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MemorialRepository extends JpaRepository<Memorial, Integer>, MemorialRepositoryCustom {

}
