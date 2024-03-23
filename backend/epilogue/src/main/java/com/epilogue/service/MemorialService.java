package com.epilogue.service;

import com.epilogue.domain.memorial.Favorite;
import com.epilogue.domain.memorial.Memorial;
import com.epilogue.domain.memorial.MemorialPhoto;
import com.epilogue.domain.user.User;
import com.epilogue.dto.response.memorial.GraveDto;
import com.epilogue.dto.response.memorial.GraveResponseDto;
import com.epilogue.dto.response.memorial.MemorialResponseDto;
import com.epilogue.repository.memorial.MemorialRepository;
import com.epilogue.repository.memorial.favorite.FavoriteRepository;
import com.epilogue.repository.memorial.photo.MemorialPhotoRepository;
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
    private final AwsS3Service awsS3Service;
    private final MemorialPhotoRepository memorialPhotoRepository;

    // 회원 (즐겨찾기 목록 포함)
    public MemorialResponseDto viewMemorialListByMember(String loginUserId) {
        MemorialResponseDto dto = new MemorialResponseDto();

        List<GraveDto> favoriteMemorialList = new ArrayList<>();
        List<GraveDto> memorialList = new ArrayList<>();

        // 1. 내가 즐겨찾기한 목록
        User loginUser = userRepository.findByUserId(loginUserId);
        int loginUserSeq = loginUser.getUserSeq();
        List<Favorite> favorites = favoriteRepository.findListById(loginUserSeq); // 내가 즐겨찾기 한 목록
        for(Favorite favorite : favorites) {
            GraveDto graveDto = GraveDto.builder()
                    .graveSeq(favorite.getMemorial().getMemorialSeq())
                    .name(favorite.getMemorial().getUser().getName())
                    .birth(favorite.getMemorial().getUser().getBirth())
                    .goneDate(favorite.getMemorial().getGoneDate())
                    .graveName(favorite.getMemorial().getGraveName())
                    .graveImg(awsS3Service.getPhotoFromS3(favorite.getMemorial().getGraveName()))
                    .build();

            favoriteMemorialList.add(graveDto);
        }

        // 2. 즐겨찾기 목록 제외한 최신순 목록
        List<Memorial> memorials = memorialRepository.findAllByDate();
        for(Memorial memorial : memorials) {
            GraveDto graveDto = GraveDto.builder()
                    .graveSeq(memorial.getMemorialSeq())
                    .name(memorial.getUser().getName())
                    .birth(memorial.getUser().getBirth())
                    .goneDate(memorial.getGoneDate())
                    .graveName(memorial.getGraveName())
                    .graveImg(awsS3Service.getPhotoFromS3(memorial.getGraveImg()))
                    .build();

            memorialList.add(graveDto);
        }

        for(int i=0; i<memorialList.size(); i++) {
            for(int j=0; j<favoriteMemorialList.size(); j++) {
                if(memorialList.get(i).getGraveSeq() == favoriteMemorialList.get(j).getGraveSeq()) {
                    memorialList.remove(i);
                }
            }
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
                    .graveSeq(memorial.getMemorialSeq())
                    .name(memorial.getUser().getName())
                    .birth(memorial.getUser().getBirth())
                    .goneDate(memorial.getGoneDate())
                    .graveName(memorial.getGraveName())
                    .graveImg(awsS3Service.getPhotoFromS3(memorial.getGraveImg()))
                    .build();

            memorialList.add(graveDto);
        }

        dto = MemorialResponseDto.builder()
                .memorialList(memorialList)
                .build();

        return dto;
    }

    public GraveResponseDto viewMemorial(int memorialSeq) {
        Optional<Memorial> memorial = memorialRepository.findById(memorialSeq);

        // 고인의 사진 url 목록 불러오기
        int userSeq = memorial.get().getUser().getUserSeq(); // 고인 식별키
        List<MemorialPhoto> memorialPhotoList = memorialPhotoRepository.findAllByUserSeq(userSeq);
        // S3 url 저장 목록
        List<String> memorialS3PhotoList = new ArrayList<>();
        for(MemorialPhoto photo : memorialPhotoList) {
            String S3url = awsS3Service.getPhotoFromS3(photo.getPhotoURL());
            memorialS3PhotoList.add(S3url);
        }

        GraveResponseDto graveResponseDto = GraveResponseDto.builder()
                .graveSeq(memorialSeq)
                .name(memorial.get().getUser().getName())
                .birth(memorial.get().getUser().getBirth())
                .goneDate(memorial.get().getGoneDate())
                .graveImg(awsS3Service.getPhotoFromS3(memorial.get().getGraveImg()))
                .memorialPhotoList(memorialS3PhotoList)
                .photoCount(memorialS3PhotoList.size())
//                .memorialVideoList()
//                .videoCount()
//                .memorialLetterList()
//                .letterCount()
                .build();





        return graveResponseDto;
    }

}
