package com.epilogue.repository.memorial.video;

import com.epilogue.domain.memorial.MemorialVideo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemorialVideoRepository extends JpaRepository<MemorialVideo, Integer>, MemorialVideoRepositoryCustom {
}
