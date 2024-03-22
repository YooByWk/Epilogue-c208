package com.epilogue.repository.memorial.photo;

import com.epilogue.domain.memorial.MemorialPhoto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemorialPhotoRepository extends JpaRepository<MemorialPhoto, Integer>, MemorialPhotoRepositoryCustom {
}
