package com.epilogue.repository.will;

import com.epilogue.domain.will.Will;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WillRepository extends JpaRepository<Will, Integer> {
<<<<<<< HEAD
    Will findByWillCode(String willCode);
=======
>>>>>>> f2fbccf279af0bc5bbd01ed9cd66bd406e8146af
}
