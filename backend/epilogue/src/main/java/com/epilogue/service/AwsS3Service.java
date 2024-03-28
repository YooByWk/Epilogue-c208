package com.epilogue.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.security.Principal;
import java.util.UUID;

import com.epilogue.domain.user.User;
import com.epilogue.domain.will.Will;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.will.WillRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.Type;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RequiredArgsConstructor
@Component
@Transactional
public class AwsS3Service {

    private final AmazonS3 amazonS3;
    private final UserRepository userRepository;

    @Value("${cloud.aws.s3.bucketName}")
    private String bucketName;
    @Value("${cloud.aws.s3.photoBucketName}")
    private String photoBucketName;
    @Value("${cloud.aws.s3.videoBucketName}")
    private String videoBucketName;
    @Value("${cloud.aws.s3.graveBucketName}")
    private String graveBucketName;

    @Transactional
    public void uploadWill(MultipartFile file, Principal principal) {
        try {
            String[] url = file.getOriginalFilename().split("\\.");
            String fileType = url[1]; // 파일 확장자
            String uniqueFileName = UUID.randomUUID() + "." + fileType; // 중복 방지를 위한 unique한 파일명

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType(file.getContentType());
            metadata.setContentLength(file.getSize());

            // 유언 파일 주소 업데이트
            User user = userRepository.findByUserId(principal.getName());
            Will will = user.getWill();
            will.updateWillFileAddress(uniqueFileName);

            amazonS3.putObject(bucketName, uniqueFileName, file.getInputStream(), metadata);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Transactional
    public void uploadGraveImage(MultipartFile file, Principal principal) {
        try {
            String[] url = file.getOriginalFilename().split("\\.");
            String fileType = url[1]; // 파일 확장자
            String uniqueFileName = UUID.randomUUID() + "." + fileType; // 중복 방지를 위한 unique한 파일명

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType(file.getContentType());

            metadata.setContentLength(file.getSize());

            // 묘비 사진 주소 업데이트
            User user = userRepository.findByUserId(principal.getName());
            Will will = user.getWill();
            will.updateGraveImageAddress(uniqueFileName);

            amazonS3.putObject(graveBucketName, uniqueFileName, file.getInputStream(), metadata);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 유언 파일 url 불러오기
    public String getWillFromS3(String fileName) {
        return amazonS3.getUrl(bucketName, fileName).toString();
    }

    // 묘비 사진 url 불러오기
    public String getGraveImageFromS3(String fileName) {
        return amazonS3.getUrl(graveBucketName, fileName).toString();
    }

    // 사진 업로드
    public void uploadPhoto(MultipartFile file, String uniqueFileName) {
        try {
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType(file.getContentType());
            metadata.setContentLength(file.getSize());

            amazonS3.putObject(photoBucketName, uniqueFileName, file.getInputStream(), metadata);
        } catch (IOException e) {
            log.info("디지털 추모관 S3에 사진 저장 실패");
            e.printStackTrace();
        }
    }

    // 사진 url 불러오기
    public String getPhotoFromS3(String fileName) {
        return amazonS3.getUrl(photoBucketName, fileName).toString();
    }

    @Transactional
    // 동영상 업로드
    public void uploadVideo(MultipartFile file, String uniqueFileName) {
        try {
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType(file.getContentType());
            metadata.setContentLength(file.getSize());

            amazonS3.putObject(videoBucketName, uniqueFileName, file.getInputStream(), metadata);
        } catch (IOException e) {
            log.info("디지털 추모관 S3에 동영상 저장 실패");
            e.printStackTrace();
        }
    }

    // 동영상 url 불러오기
    public String getVideoFromS3(String fileName) {
        return amazonS3.getUrl(videoBucketName, fileName).toString();
    }

    public void deleteFromS3(Principal principal) throws MalformedURLException, UnsupportedEncodingException {
        Will will = userRepository.findByUserId(principal.getName()).getWill();

        String key = will.getWillFileAddress();
        amazonS3.deleteObject(new DeleteObjectRequest(bucketName, key));
    }
}