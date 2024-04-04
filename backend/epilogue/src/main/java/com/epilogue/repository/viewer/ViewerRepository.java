package com.epilogue.repository.viewer;

import com.epilogue.domain.viewer.Viewer;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ViewerRepository extends JpaRepository<Viewer, Integer> {
    @Transactional
    void deleteAllByWillWillSeq(int willSeq);

    List<Viewer> findAllByWillWillSeq(int willSeq);
}
