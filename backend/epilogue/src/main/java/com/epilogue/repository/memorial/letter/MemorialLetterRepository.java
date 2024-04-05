package com.epilogue.repository.memorial.letter;

import com.epilogue.domain.memorial.MemorialLetter;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemorialLetterRepository extends JpaRepository<MemorialLetter, Integer>, MemorialLetterRepositoryCustom {
}
