package com.epilogue.repository.memorial;

import com.epilogue.domain.memorial.Memorial;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemorialRepositoryCustom {

    public List<Memorial> findAllByDate();

}
