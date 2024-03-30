package com.epilogue.config;

import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.query.JpaQueryMethodFactory;

@Configuration
@RequiredArgsConstructor
public class QueryDSLConfig {
    private final EntityManager entityManager;

//    @Bean
//    public JpaQueryMethodFactory jpaQueryMethodFactory() {
//        return new JpaQueryMethodFactory(entityManager);
//    }

//    @Bean
//    public JPAQueryFactory jpaQueryFactory() {
//        return new JPAQueryFactory(entityManager);
//    }



}
