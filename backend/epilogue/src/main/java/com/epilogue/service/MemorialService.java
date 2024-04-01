package com.epilogue.service;

import com.epilogue.domain.memorial.*;
import com.epilogue.domain.user.User;
import com.epilogue.dto.request.SearchRequestDto;
import com.epilogue.dto.request.memorial.MemorialLetterRequestDto;
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
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.awt.print.Pageable;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

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
        for (Favorite favorite : favorites) {
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
        for (Memorial memorial : memorials) {
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

        for (int i = 0; i < memorialList.size(); i++) {
            for (int j = 0; j < favoriteMemorialList.size(); j++) {
                if (memorialList.get(i).getGraveSeq() == favoriteMemorialList.get(j).getGraveSeq()) {
                    memorialList.remove(i);
                }
            }
        }

        dto = MemorialResponseDto.builder().favoriteMemorialList(favoriteMemorialList).memorialList(memorialList).build();

        return dto;
    }

    // 비회원 (즐겨찾기 목록 제외)
    public MemorialResponseDto viewMemorialListByNonMember() {
        MemorialResponseDto dto = new MemorialResponseDto();

        List<GraveDto> memorialList = new ArrayList<>();

        List<Memorial> list = memorialRepository.findAllByDate();
        for (Memorial memorial : list) {
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

        dto = MemorialResponseDto.builder().memorialList(memorialList).build();

        return dto;
    }

//    public GraveResponseDto viewMemorial(int memorialSeq) {
//        Optional<Memorial> memorial = memorialRepository.findById(memorialSeq);
//        int userSeq = memorial.get().getUser().getUserSeq(); // 고인 식별키
//
//        // 고인의 사진 url 목록 불러오기 (최근순)
//        List<MemorialPhoto> memorialPhotoList = memorialPhotoRepository.findAllByUserSeq(userSeq);
//        // S3에 저장되어 있는 url 목록 불러오기
//        List<MemorialPhotoDto> memorialPhotoDtoList = new ArrayList<>();
//        for (MemorialPhoto photo : memorialPhotoList) {
//            String S3url = awsS3Service.getPhotoFromS3(photo.getUniquePhotoUrl());
//            MemorialPhotoDto memorialPhotoDto = MemorialPhotoDto.builder()
//                    .memorialPhotoSeq(photo.getMemorialPhotoSeq())
//                    .S3url(S3url)
//                    .build();
//            memorialPhotoDtoList.add(memorialPhotoDto);
//        }
//
//        // 고인의 동영상 url 목록 불러오기 (최근순)
//        List<MemorialVideo> memorialVideoList = memorialVideoRepository.findAllByUserSeq(userSeq);
//        // S3에 저장되어 있는 url 목록 불러오기
//        List<MemorialVideoDto> memorialVideoDtoList = new ArrayList<>();
//        for (MemorialVideo video : memorialVideoList) {
//            String S3url = awsS3Service.getVideoFromS3(video.getUniqueVideoUrl());
//            MemorialVideoDto memorialVideoDto = MemorialVideoDto.builder()
//                    .memorialVideoSeq(video.getMemorialVideoSeq())
//                    .S3url(S3url)
//                    .build();
//            memorialVideoDtoList.add(memorialVideoDto);
//        }
//
//        // 고인의 편지 목록 불러오기 (최근순)
//        List<MemorialLetterDto> memorialLetterDtoList = new ArrayList<>();
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
//
//        List<MemorialLetter> memorialLetterList = memorialLetterRepository.findAllByUserSeq(userSeq);
//        for(MemorialLetter letter : memorialLetterList) {
//            MemorialLetterDto memorialLetterDto = MemorialLetterDto.builder()
//                    .memorialLetterSeq(letter.getMemorialLetterSeq())
//                    .nickname(letter.getNickname())
//                    .content(letter.getContent())
//                    .writtenDate(sdf.format(letter.getWrittenDate()))
//                    .build();
//            memorialLetterDtoList.add(memorialLetterDto);
//        }
//
//        GraveResponseDto graveResponseDto = GraveResponseDto.builder()
//                .graveSeq(memorialSeq)
//                .name(memorial.get().getUser().getName())
//                .birth(memorial.get().getUser().getBirth())
//                .goneDate(memorial.get().getGoneDate())
//                .graveImg(awsS3Service.getGraveImageFromS3(memorial.get().getGraveImg()))
//                .memorialPhotoList(memorialPhotoDtoList)
//                .photoCount(memorialPhotoDtoList.size())
//                .memorialVideoList(memorialVideoDtoList)
//                .videoCount(memorialVideoDtoList.size())
//                .memorialLetterList(memorialLetterDtoList)
//                .letterCount(memorialLetterList.size())
//                .build();
//
//        return graveResponseDto;
//    }

    public GraveResponseDto viewMemorial(int memorialSeq) {
        Optional<Memorial> memorial = memorialRepository.findById(memorialSeq);
        int userSeq = memorial.get().getUser().getUserSeq(); // 고인 식별키

        // 고인의 사진 url 목록 불러오기 (최근순 20개)
        List<MemorialPhoto> memorialPhotoList20 = memorialPhotoRepository.find20ByUserSeq(userSeq);

        // S3에 저장되어 있는 url 목록 불러오기
        List<MemorialPhotoDto> memorialPhotoDtoList = new ArrayList<>();
        for (MemorialPhoto photo : memorialPhotoList20) {
            String S3url = awsS3Service.getPhotoFromS3(photo.getUniquePhotoUrl());
            MemorialPhotoDto memorialPhotoDto = MemorialPhotoDto.builder()
                    .memorialPhotoSeq(photo.getMemorialPhotoSeq())
                    .S3url(S3url)
                    .build();
            memorialPhotoDtoList.add(memorialPhotoDto);
        }

        // 고인의 사진 url 목록 불러오기 (카운트용)
        List<MemorialPhoto> memorialPhotoList = memorialPhotoRepository.findAllByUserSeq(userSeq);

        // 고인의 동영상 url 목록 불러오기 (카운트용)
        List<MemorialVideo> memorialVideoList = memorialVideoRepository.findAllByUserSeq(userSeq);

        // 고인의 편지 목록 불러오기 (카운트용)
        List<MemorialLetter> memorialLetterList = memorialLetterRepository.findAllByUserSeq(userSeq);

        GraveResponseDto graveResponseDto = GraveResponseDto.builder()
                .graveSeq(memorialSeq)
                .name(memorial.get().getUser().getName())
                .birth(memorial.get().getUser().getBirth())
                .goneDate(memorial.get().getGoneDate())
                .graveImg(awsS3Service.getGraveImageFromS3(memorial.get().getGraveImg()))
                .memorialPhotoList(memorialPhotoDtoList)
                .photoCount(memorialPhotoList.size())
                .videoCount(memorialVideoList.size())
                .letterCount(memorialLetterList.size())
                .build();

        return graveResponseDto;
    }

    public MemorialPhotoListResponseDto viewMemorialPhotoList(int memorialSeq, int lastPhotoSeq) {
        List<MemorialPhotoDto> memorialPhotoDtoList = new ArrayList<>();

        List<MemorialPhoto> memorialPhotoList = new ArrayList<>();
        // 사진 처음 로드시
        if(lastPhotoSeq == 0) {
            memorialPhotoList = memorialPhotoRepository.find20ByMemorialSeq(memorialSeq);
        }
        // 추가 로드시 (lastPhotoSeq 있는 경우)
        else {
            memorialPhotoList = memorialPhotoRepository.find20ByMemorialSeqAndLastPhotoSeq(memorialSeq, lastPhotoSeq);
        }

        for(MemorialPhoto photo : memorialPhotoList) {
            MemorialPhotoDto memorialPhotoDto = MemorialPhotoDto.builder()
                    .memorialPhotoSeq(photo.getMemorialPhotoSeq())
                    .S3url(awsS3Service.getPhotoFromS3(photo.getUniquePhotoUrl()))
                    .build();
            memorialPhotoDtoList.add(memorialPhotoDto);
        }

        return MemorialPhotoListResponseDto.builder()
                .memorialPhotoDtoList(memorialPhotoDtoList)
                .count(memorialPhotoRepository.findAllByMemorialSeq(memorialSeq).size())
                .build();
    }

    public MemorialVideoListResponseDto viewMemorialVideoList(int memorialSeq, int lastVideoSeq) {
        List<MemorialVideoDto> memorialVideoDtoList = new ArrayList<>();

        List<MemorialVideo> memorialVideoList = new ArrayList<>();
        // 동영상 처음 로드시
        if(lastVideoSeq == 0) {
            memorialVideoList = memorialVideoRepository.find20ByMemorialSeq(memorialSeq);
        }
        // 추가 로드시 (lastVideoSeq 있는 경우)
        else {
            memorialVideoList = memorialVideoRepository.find20ByMemorialSeqAndLastVideoSeq(memorialSeq, lastVideoSeq);
        }

        for(MemorialVideo video : memorialVideoList) {
            MemorialVideoDto memorialVideoDto = MemorialVideoDto.builder()
                    .memorialVideoSeq(video.getMemorialVideoSeq())
                    .S3url(awsS3Service.getVideoFromS3(video.getUniqueVideoUrl()))
                    .build();
            memorialVideoDtoList.add(memorialVideoDto);
        }

        return MemorialVideoListResponseDto.builder()
                .memorialVideoDtoList(memorialVideoDtoList)
                .count(memorialVideoRepository.findAllByMemorialSeq(memorialSeq).size())
                .build();
    }

    public void saveMedia(String loginUserId, int memorialSeq, MultipartFile multipartFile, MemorialMediaRequestDto memorialMediaRequestDto) throws Exception {
        String[] url = multipartFile.getOriginalFilename().split("\\.");
        String fileType = url[1]; // 파일 확장자
        String originalFileName = multipartFile.getOriginalFilename(); // 원래 파일명
        String uniqueFileName = UUID.randomUUID() + "." + fileType; // 중복 방지를 위한 unique한 파일명

        // 사진 저장
        if (fileType.equals("jpg") || fileType.equals("jpeg") || fileType.equals("png") || fileType.equals("gif")) {
            // DB
            MemorialPhoto memorialPhoto = MemorialPhoto.builder()
                    .originalPhotoUrl(originalFileName)
                    .uniquePhotoUrl(uniqueFileName)
                    .memorial(memorialRepository.findById(memorialSeq).get())
                    .user(userRepository.findByUserId(loginUserId))
                    .content(memorialMediaRequestDto.getContent())
                    .writtenDate(new Timestamp(System.currentTimeMillis()))
                    .reportCount(0)
                    .build();
            memorialPhotoRepository.save(memorialPhoto);

            // S3
            awsS3Service.uploadPhoto(multipartFile, uniqueFileName);
        }

        // 동영상 저장
        else if (fileType.equals("mp4") || fileType.equals("mov")) {
            // DB
            MemorialVideo memorialVideo = MemorialVideo.builder()
                    .originalVideoUrl(originalFileName)
                    .uniqueVideoUrl(uniqueFileName)
                    .memorial(memorialRepository.findById(memorialSeq).get())
                    .user(userRepository.findByUserId(loginUserId))
                    .content(memorialMediaRequestDto.getContent())
                    .writtenDate(new Timestamp(System.currentTimeMillis()))
                    .reportCount(0)
                    .build();
            memorialVideoRepository.save(memorialVideo);

            // S3
            awsS3Service.uploadVideo(multipartFile, uniqueFileName);
        } else {
            log.error("{ error = 지원하지 않는 확장자입니다. }");
            throw new Exception();
        }

    }

    public MemorialMediaResponseDto viewMemorialPhoto(int memorialPhotoSeq) {
        Optional<MemorialPhoto> memorialPhoto = memorialPhotoRepository.findById(memorialPhotoSeq);
        MemorialMediaResponseDto memorialMediaResponseDto =
                MemorialMediaResponseDto.builder()
                        .mediaSeq(memorialPhoto.get().getMemorialPhotoSeq())
                        .S3url(awsS3Service.getPhotoFromS3(memorialPhoto.get().getUniquePhotoUrl()))
                        .content(memorialPhoto.get().getContent())
                        .reportCount(memorialPhoto.get().getReportCount())
                        .build();
        return memorialMediaResponseDto;
    }

    public MemorialMediaResponseDto viewMemorialVideo(int memorialVideoSeq) {
        Optional<MemorialVideo> memorialVideo = memorialVideoRepository.findById(memorialVideoSeq);
        MemorialMediaResponseDto memorialMediaResponseDto = MemorialMediaResponseDto.builder().mediaSeq(memorialVideo.get().getMemorialVideoSeq()).S3url(awsS3Service.getVideoFromS3(memorialVideo.get().getUniqueVideoUrl())).content(memorialVideo.get().getContent()).reportCount(memorialVideo.get().getReportCount()).build();
        return memorialMediaResponseDto;
    }

    public MemorialLetterListResponseDto viewMemorialLetterList(int memorialSeq, int lastLetterSeq) {
        List<MemorialLetterDto> memorialLetterDtoList = new ArrayList<>();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
        List<MemorialLetter> memorialLetterList = new ArrayList<>();

        if(lastLetterSeq == 0) {
            memorialLetterList = memorialLetterRepository.find20ByMemorialSeq(memorialSeq);
        } else {
            memorialLetterList = memorialLetterRepository.find20ByMemorialSeqAndLastLetterSeq(memorialSeq, lastLetterSeq);
        }

        for (MemorialLetter letter : memorialLetterList) {
            MemorialLetterDto memorialLetterDto = MemorialLetterDto.builder()
                    .memorialLetterSeq(letter.getMemorialLetterSeq())
                    .nickname(letter.getNickname())
                    .content(letter.getContent())
                    .writtenDate(sdf.format(letter.getWrittenDate()))
                    .build();
            memorialLetterDtoList.add(memorialLetterDto);
        }
        return MemorialLetterListResponseDto.builder()
                .memorialLetterDtoList(memorialLetterDtoList)
                .count(memorialLetterRepository.findAllByMemorialSeq(memorialSeq).size())
                .build();
    }

    public void createMemorialLetter(int memorialSeq, MemorialLetterRequestDto memorialLetterRequestDto) {
        MemorialLetter memorialLetter = MemorialLetter.builder()
                .nickname(memorialLetterRequestDto.getNickname())
                .content(memorialLetterRequestDto.getContent())
                .writtenDate(new Timestamp(System.currentTimeMillis()))
                .memorial(memorialRepository.findById(memorialSeq).get())
                .build();

        memorialLetterRepository.save(memorialLetter);
    }

    public void createMemorialFavorite(String loginUserId, int memorialSeq) {
        Favorite favorite = Favorite.builder()
                .user(userRepository.findByUserId(loginUserId))
                .memorial(memorialRepository.findById(memorialSeq).get())
                .build();
        log.info("======================================");
        log.info("favorite/memorialSeq = {}", favorite.getMemorial().getMemorialSeq());
        favoriteRepository.save(favorite);
    }

    public List<GraveDto> viewMyFavoriteGraveList(String loginUserId) {
        List<GraveDto> graveDtoList = new ArrayList<>();

        List<Favorite> myFavoriteList = favoriteRepository.findByUserId(loginUserId);
        for (Favorite favorite : myFavoriteList) {
            GraveDto graveDto = GraveDto.builder().graveSeq(favorite.getMemorial().getMemorialSeq()).name(favorite.getMemorial().getUser().getName()).birth(favorite.getMemorial().getUser().getBirth()).goneDate(favorite.getMemorial().getGoneDate()).graveName(favorite.getMemorial().getGraveName()).graveImg(awsS3Service.getGraveImageFromS3(favorite.getMemorial().getGraveImg())).build();
            graveDtoList.add(graveDto);
        }
        return graveDtoList;
    }

    @Transactional
    public void report(String type, int mediaSeq) {
        if (type.equals("photo")) {
            Optional<MemorialPhoto> memorialPhoto = memorialPhotoRepository.findById(mediaSeq);
            int updatedReportCount = memorialPhoto.get().getReportCount() + 1;
            memorialPhoto.get().setReportCount(updatedReportCount);

            // 신고수 10개 이상이면 사진 삭제
            if (updatedReportCount >= 10) {
                memorialPhotoRepository.deleteById(memorialPhoto.get().getMemorialPhotoSeq());
            }
        } else if (type.equals("video")) {
            Optional<MemorialVideo> memorialVideo = memorialVideoRepository.findById(mediaSeq);
            int updatedReportCount = memorialVideo.get().getReportCount() + 1;
            memorialVideo.get().setReportCount(updatedReportCount);

            // 신고수 10개 이상이면 사진 삭제
            if (updatedReportCount >= 10) {
                memorialVideoRepository.deleteById(memorialVideo.get().getMemorialVideoSeq());
            }
        }
    }

    public List<GraveDto> searchedMemorialList(SearchRequestDto searchRequestDto) {
        List<GraveDto> graveDtoList = new ArrayList<>();
        System.out.println(searchRequestDto.getSearchWord());
        List<Memorial> memorialList = memorialRepository.findMemorialsByGraveNameOrUserName(searchRequestDto.getSearchWord());

        for (Memorial memorial : memorialList) {
            GraveDto graveDto = GraveDto.builder()
                    .graveSeq(memorial.getMemorialSeq())
                    .name(memorial.getUser().getName())
                    .birth(memorial.getUser().getBirth())
                    .goneDate(memorial.getGoneDate())
                    .graveName(memorial.getGraveName())
                    .graveImg(awsS3Service.getGraveImageFromS3(memorial.getGraveImg()))
                    .build();
            graveDtoList.add(graveDto);
        }
        return graveDtoList;
    }

}
