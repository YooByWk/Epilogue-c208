package com.epilogue.service;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.util.IOUtils;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RequiredArgsConstructor
@Component
public class AwsS3Service {

    private final AmazonS3 amazonS3;

    @Value("${cloud.aws.s3.bucketName}")
    private String bucketName;

    public String upload(MultipartFile mp3) {
        if(mp3.isEmpty() || Objects.isNull(mp3.getOriginalFilename())){
//            throw new S3Exception(ErrorCode.EMPTY_FILE_EXCEPTION);
        }
        return this.uploadMp3(mp3);
    }

    private String uploadMp3(MultipartFile mp3) {
        this.validatemp3FileExtention(mp3.getOriginalFilename());
        try {
            return this.uploadMp3ToS3(mp3);
        } catch (IOException e) {
//            throw new S3Exception(ErrorCode.IO_EXCEPTION_ON_MP3_UPLOAD);
        }
        
        // 이 부분 수정
        return "";
    }

    private void validatemp3FileExtention(String filename) {
        int lastDotIndex = filename.lastIndexOf(".");
        if (lastDotIndex == -1) {
//            throw new S3Exception(ErrorCode.NO_FILE_EXTENTION);
        }

        String extention = filename.substring(lastDotIndex + 1).toLowerCase();
        List<String> allowedExtentionList = Arrays.asList("mp3");

        if (!allowedExtentionList.contains(extention)) {
//            throw new S3Exception(ErrorCode.INVALID_FILE_EXTENTION);
        }
    }

    private String uploadMp3ToS3(MultipartFile mp3) throws IOException {
        String originalFilename = mp3.getOriginalFilename(); //원본 파일 명
        String extention = originalFilename.substring(originalFilename.lastIndexOf(".")); //확장자 명

        String s3FileName = UUID.randomUUID().toString().substring(0, 10) + originalFilename; //변경된 파일 명

        InputStream is = mp3.getInputStream();
        byte[] bytes = IOUtils.toByteArray(is);

        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType("mp3/" + extention);
        metadata.setContentLength(bytes.length);
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

        try{
            PutObjectRequest putObjectRequest =
                    new PutObjectRequest(bucketName, s3FileName, byteArrayInputStream, metadata)
                            .withCannedAcl(CannedAccessControlList.PublicRead);
            amazonS3.putObject(putObjectRequest); // put mp3 to S3
        }catch (Exception e){
//            throw new S3Exception(ErrorCode.PUT_OBJECT_EXCEPTION);
        }finally {
            byteArrayInputStream.close();
            is.close();
        }

        return amazonS3.getUrl(bucketName, s3FileName).toString();
    }

    public void deleteMp3FromS3(String mp3Address){
        String key = getKeyFromMp3Address(mp3Address);
        try{
            amazonS3.deleteObject(new DeleteObjectRequest(bucketName, key));
        }catch (Exception e){
//            throw new S3Exception(ErrorCode.IO_EXCEPTION_ON_MP3_DELETE);
        }
    }

    private String getKeyFromMp3Address(String mp3Address){
        try{
            URL url = new URL(mp3Address);
            String decodingKey = URLDecoder.decode(url.getPath(), "UTF-8");
            return decodingKey.substring(1); // 맨 앞의 '/' 제거
        }catch (MalformedURLException | UnsupportedEncodingException e){
//            throw new S3Exception(ErrorCode.IO_EXCEPTION_ON_MP3_DELETE);
        }
        
        // 이 부분 수정
        return "";
    }
}