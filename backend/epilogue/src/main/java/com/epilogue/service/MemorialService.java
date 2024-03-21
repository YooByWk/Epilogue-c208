package com.epilogue.service;

import com.epilogue.domain.memorial.Favorite;
import com.epilogue.domain.memorial.Memorial;
import com.epilogue.domain.user.User;
import com.epilogue.dto.response.memorial.GraveDto;
import com.epilogue.dto.response.memorial.MemorialResponseDto;
import com.epilogue.repository.memorial.MemorialRepository;
import com.epilogue.repository.memorial.favorite.FavoriteRepository;
import com.epilogue.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemorialService {

    private final MemorialRepository memorialRepository;
    private final FavoriteRepository favoriteRepository;
    private final UserRepository userRepository;

    // 회원 (즐겨찾기 목록 포함)
    public MemorialResponseDto viewMemorialListByMember(String loginUserId) {
        MemorialResponseDto dto = new MemorialResponseDto();

        List<GraveDto> favoriteMemorialList = new ArrayList<>();
        List<GraveDto> memorialList = new ArrayList<>();

        // 내가 즐겨찾기한 목록
        User loginUser = userRepository.findByUserId(loginUserId);
        int loginUserSeq = loginUser.getUserSeq();
        List<Favorite> favorites = favoriteRepository.findListById(loginUserSeq); // 내가 즐겨찾기 한 목록
        for(Favorite favorite : favorites) {
            GraveDto graveDto = GraveDto.builder()
                    .name(favorite.getMemorial().getUser().getName())
                    .birth(favorite.getMemorial().getUser().getBirth())
                    .goneDate(favorite.getMemorial().getGoneDate())
                    .graveName(favorite.getMemorial().getGraveName())
                    .graveImg(favorite.getMemorial().getGraveImg())
                    .build();

            favoriteMemorialList.add(graveDto);
        }

        // 즐겨찾기 목록 제외한 최신순 목록
        List<Memorial> memorials = memorialRepository.findAll();
        for(Memorial memorial : memorials) {
            // 회원의 최신순 목록에 즐겨찾기 목록은 제외
            for(Favorite favorite : favorites) {
                if(memorial.getMemorialSeq() == favorite.getMemorial().getMemorialSeq()) {
//                    System.out.println("memorial.getMemorialSeq() : " + memorial.getMemorialSeq());
//                    System.out.println("favorite.getMemorial().getMemorialSeq() : " + favorite.getMemorial().getMemorialSeq());
                    break;
                }
            }
            GraveDto graveDto = GraveDto.builder()
                    .name(memorial.getUser().getName())
                    .birth(memorial.getUser().getBirth())
                    .goneDate(memorial.getGoneDate())
                    .graveName(memorial.getGraveName())
                    .graveImg(memorial.getGraveImg())
                    .build();

            memorialList.add(graveDto);
        }

        dto = MemorialResponseDto.builder()
                .favoriteMemorialList(favoriteMemorialList)
                .memorialList(memorialList)
                .build();

        return dto;
    }

    // 비회원 (즐겨찾기 목록 제외)
    public MemorialResponseDto viewMemorialListByNonMember() {
        MemorialResponseDto dto = new MemorialResponseDto();

        List<GraveDto> memorialList = new ArrayList<>();

        List<Memorial> list = memorialRepository.findAllByDate();
        for(Memorial memorial : list) {
            GraveDto graveDto = GraveDto.builder()
                    .name(memorial.getUser().getName())
                    .birth(memorial.getUser().getBirth())
                    .goneDate(memorial.getGoneDate())
                    .graveName(memorial.getGraveName())
                    .graveImg(memorial.getGraveImg())
                    .build();

            memorialList.add(graveDto);
        }

        dto = MemorialResponseDto.builder()
                .memorialList(memorialList)
                .build();

        return dto;
    }

}
