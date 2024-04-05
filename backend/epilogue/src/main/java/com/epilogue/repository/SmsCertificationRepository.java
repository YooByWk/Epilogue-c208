package com.epilogue.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Repository;

import java.time.Duration;

@RequiredArgsConstructor
@Repository
public class SmsCertificationRepository {
    private final String PREFIX = "sms:";

    private final StringRedisTemplate redisTemplate;

    public void createSmsCertification(String phone, String certificationNumber) {
        int LIMIT_TIME = 30 * 60;
        redisTemplate.opsForValue().set(PREFIX + phone, certificationNumber, Duration.ofSeconds(LIMIT_TIME));
    }

    public String getSmsCertification(String phone) {
        return redisTemplate.opsForValue().get(PREFIX + phone);
    }

    public void removeSmsCertification(String phone) {
        redisTemplate.delete(PREFIX + phone);
    }

    public boolean hasKey(String phone) {
        return Boolean.TRUE.equals(redisTemplate.hasKey(PREFIX + phone));
    }
}
