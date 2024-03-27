package com.epilogue.service;

import com.epilogue.domain.memorial.*;
import com.epilogue.domain.user.User;
import com.epilogue.dto.request.memorial.MemorialMediaRequestDto;
import com.epilogue.dto.response.memorial.*;
import com.epilogue.repository.memorial.MemorialRepository;
import com.epilogue.repository.memorial.favorite.FavoriteRepository;
import com.epilogue.repository.memorial.letter.MemorialLetterRepository;
import com.epilogue.repository.memorial.photo.MemorialPhotoRepository;
import com.epilogue.repository.memorial.video.MemorialVideoRepository;
import com.epilogue.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemorialService {

    private final MemorialRepository memorialRepository;
    private final FavoriteRepository favoriteRepository;
    private final UserRepository userRepository;
    private final AwsS3Service awsS3Service;
    private final MemorialPhotoRepository memorialPhotoRepository;
    private final MemorialVideoRepository memorialVideoRepository;
    private final MemorialLetterRepository memorialLetterRepository;

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
        int userSeq = memorial.get().getUser().getUserSeq(); // 고인 식별키

        // 고인의 사진 url 목록 불러오기
        List<MemorialPhoto> memorialPhotoList = memorialPhotoRepository.findAllByUserSeq(userSeq);
        // S3에 저장되어 있는 url 목록 불러오기
        List<MemorialPhotoDto> memorialPhotoDtoList = new ArrayList<>();
        for(MemorialPhoto photo : memorialPhotoList) {
            String S3url = awsS3Service.getPhotoFromS3(photo.getUniquePhotoUrl());
            MemorialPhotoDto memorialPhotoDto = MemorialPhotoDto.builder()
                    .memorialPhotoSeq(photo.getMemorialPhotoSeq())
                    .S3url(S3url)
                    .build();
            memorialPhotoDtoList.add(memorialPhotoDto);
        }

        // 고인의 동영상 url 목록 불러오기
        List<MemorialVideo> memorialVideoList = memorialVideoRepository.findAllByUserSeq(userSeq);
        // S3에 저장되어 있는 url 목록 불러오기
        List<MemorialVideoDto> memorialVideoDtoList = new ArrayList<>();
        for(MemorialVideo video : memorialVideoList) {
            String S3url = awsS3Service.getVideoFromS3(video.getUniqueVideoUrl());
            MemorialVideoDto memorialVideoDto = MemorialVideoDto.builder()
                    .memorialVideoSeq(video.getMemorialVideoSeq())
                    .S3url(S3url)
                    .build();
            memorialVideoDtoList.add(memorialVideoDto);
        }

        // 고인의 편지 목록 불러오기
        List<MemorialLetter> memorialLetterList = memorialLetterRepository.findAllByUserSeq(userSeq);

        GraveResponseDto graveResponseDto = GraveResponseDto.builder()
                .graveSeq(memorialSeq)
                .name(memorial.get().getUser().getName())
                .birth(memorial.get().getUser().getBirth())
                .goneDate(memorial.get().getGoneDate())
                .graveImg(awsS3Service.getGraveImageFromS3(memorial.get().getGraveImg()))
                .memorialPhotoList(memorialPhotoDtoList)
                .photoCount(memorialPhotoDtoList.size())
                .memorialVideoList(memorialVideoDtoList)
                .videoCount(memorialVideoDtoList.size())
                .memorialLetterList(memorialLetterList)
                .letterCount(memorialLetterList.size())
                .build();

        return graveResponseDto;
    }

    public void saveMedia(String loginUserId, int memorialSeq, MultipartFile multipartFile, MemorialMediaRequestDto memorialMediaRequestDto) throws Exception {
        String[] url = multipartFile.getOriginalFilename().split("\\.");
        String fileType = url[1]; // 파일 확장자
        String originalFileName = multipartFile.getOriginalFilename(); // 원래 파일명
        String uniqueFileName = UUID.randomUUID() + "." + fileType; // 중복 방지를 위한 unique한 파일명

        // 사진 저장
        if(fileType.equals("jpg") || fileType.equals("jpeg") || fileType.equals("png") || fileType.equals("gif")) {
            // DB
            MemorialPhoto memorialPhoto = MemorialPhoto.builder()
                    .originalPhotoUrl(originalFileName)
                    .uniquePhotoUrl(uniqueFileName)
                    .memorial(memorialRepository.findById(memorialSeq).get())
                    .user(userRepository.findByUserId(loginUserId))
                    .content(memorialMediaRequestDto.getContent())
                    .build();
            memorialPhotoRepository.save(memorialPhoto);

            // S3
            awsS3Service.uploadPhoto(multipartFile, uniqueFileName);
        }

        // 동영상 저장
        else if(fileType.equals("mp4") || fileType.equals("mov")) {
            // DB
            MemorialVideo memorialVideo = MemorialVideo.builder()
                    .originalVideoUrl(originalFileName)
                    .uniqueVideoUrl(uniqueFileName)
                    .memorial(memorialRepository.findById(memorialSeq).get())
                    .user(userRepository.findByUserId(loginUserId))
                    .content(memorialMediaRequestDto.getContent())
                    .build();
            memorialVideoRepository.save(memorialVideo);

            // S3
            awsS3Service.uploadVideo(multipartFile, uniqueFileName);
        }

        else {
            log.error("{ error = 지원하지 않는 확장자입니다. }");
            throw new Exception();
        }

    }

    public MemorialMediaResponseDto viewMemorialPhoto(int memorialPhotoSeq) {
        Optional<MemorialPhoto> memorialPhoto = memorialPhotoRepository.findById(memorialPhotoSeq);
        MemorialMediaResponseDto memorialMediaResponseDto = MemorialMediaResponseDto.builder()
                .S3url(awsS3Service.getPhotoFromS3(memorialPhoto.get().getUniquePhotoUrl()))
                .content(memorialPhoto.get().getContent())
                .build();
        return memorialMediaResponseDto;
    }

    public MemorialMediaResponseDto viewMemorialVideo(int memorialVideoSeq) {
        Optional<MemorialVideo> memorialVideo = memorialVideoRepository.findById(memorialVideoSeq);
        MemorialMediaResponseDto memorialMediaResponseDto = MemorialMediaResponseDto.builder()
                .S3url(awsS3Service.getVideoFromS3(memorialVideo.get().getUniqueVideoUrl()))
                .content(memorialVideo.get().getContent())
                .build();
        return memorialMediaResponseDto;
    }

}
