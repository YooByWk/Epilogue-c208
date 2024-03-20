package com.epilogue.service;

import com.epilogue.dto.response.memorial.MemorialResponseDto;
import com.epilogue.repository.memorial.MemorialRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MemorialService {

    private final MemorialRepository memorialRepository;

    public List<MemorialResponseDto> viewMemorialList(String loginUserId) {
        List<MemorialResponseDto> favoriteMemorialList = new ArrayList<>();
        List<MemorialResponseDto> memorialList = new ArrayList<>();

        if(loginUserId != null) { // 회원

        } else { // 비회원
            memorialRepository.findAll();
        }
        return memorialList;
    }

}
