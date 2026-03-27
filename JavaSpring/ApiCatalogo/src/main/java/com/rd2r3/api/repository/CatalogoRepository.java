package com.rd2r3.api.repository;
    
import org.springframework.data.jpa.repository.JpaRepository;

import com.rd2r3.api.entity.CatalogoEntity;

public interface CatalogoRepository extends JpaRepository<CatalogoEntity, Long> {
}
