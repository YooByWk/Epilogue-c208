package com.epilogue.controller;

import com.amazonaws.Response;
import com.epilogue.dto.request.memorial.MemorialMediaRequestDto;
import com.epilogue.dto.response.memorial.GraveDto;
import com.epilogue.dto.response.memorial.GraveResponseDto;
import com.epilogue.dto.response.memorial.MemorialResponseDto;
import com.epilogue.service.MemorialService;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/memorial")
@Tag(name = "Memorial Controller", description = "디지털 추모관 관련 API")
@Slf4j
public class MemorialController {

    private final MemorialService memorialService;

    @GetMapping("/list")
    @ApiResponse(responseCode = "200", description = "성공")
    public ResponseEntity<MemorialResponseDto> ViewMemorialList(Principal principal) {
        MemorialResponseDto memorialResponseDto = new MemorialResponseDto();

        if(principal != null) { // 회원
            String loginUserId = principal.getName();
            memorialResponseDto = memorialService.viewMemorialListByMember(loginUserId);
        } else { // 비회원
            memorialResponseDto = memorialService.viewMemorialListByNonMember();
        }

        return new ResponseEntity<>(memorialResponseDto, HttpStatus.OK);
    }

    @GetMapping("/visit/{memorialSeq}")
    @ApiResponse(responseCode = "200", description = "성공")
    public ResponseEntity<GraveResponseDto> viewMemorial(@Parameter(description = "디지털 추모관 식별키") @PathVariable int memorialSeq) {
        GraveResponseDto graveResponseDto = memorialService.viewMemorial(memorialSeq);
        return new ResponseEntity<>(graveResponseDto, HttpStatus.OK);
    }

    @PostMapping(value = "/media/{memorialSeq}", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    @ApiResponse(responseCode = "200", description = "성공")
    @ApiResponse(responseCode = "400", description = "파일명 또는 파일 확장자 에러")
    @ApiResponse(responseCode = "403", description = "로그인 에러")
//    public ResponseEntity<Void> saveMedia(@Parameter(description = "디지털 추모관 식별키") @PathVariable int memorialSeq, MemorialMediaRequestDto memorialMediaRequestDto, Principal principal) throws Exception {
    public ResponseEntity<Void> saveMedia(@Parameter(description = "디지털 추모관 식별키") @PathVariable int memorialSeq, @RequestPart(value = "multipartFile", required = true) MultipartFile multipartFile, @RequestPart(value = "memorialMediaRequestDto") MemorialMediaRequestDto memorialMediaRequestDto, Principal principal) throws Exception {
        if(principal != null) {
            String loginUserId = principal.getName();

            log.info("============================================");
            log.info("url = {}", multipartFile.getOriginalFilename());

            // url 형식 검사
            String[] urlCheck = multipartFile.getOriginalFilename().split("\\.");
            log.info("url = {}", urlCheck[0] + " " + urlCheck[1]);
            if(urlCheck.length > 2) {
                log.error("{ error = 파일명에 .을 사용할 수 없습니다. }");
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }

            memorialService.saveMedia(loginUserId, memorialSeq, multipartFile, memorialMediaRequestDto);
        } else {
            log.error("{ error = 회원가입 후 이용해주세요. }");
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }


}
