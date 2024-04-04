package com.epilogue.repository.memorial.photo;

import com.epilogue.domain.memorial.MemorialPhoto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface MemorialPhotoRepository extends JpaRepository<MemorialPhoto, Integer>, MemorialPhotoRepositoryCustom {
}
