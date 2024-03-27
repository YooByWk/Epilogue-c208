package com.epilogue.repository.viewer;

import com.epilogue.domain.viewer.Viewer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ViewerRepository extends JpaRepository<Viewer, Integer> {
    void deleteAllByWillWillSeq(int willSeq);
}
