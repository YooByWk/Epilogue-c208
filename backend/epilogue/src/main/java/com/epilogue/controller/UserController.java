package com.epilogue.controller;

import com.epilogue.dto.request.user.IdCheckRequestDto;
import com.epilogue.dto.request.user.JoinRequestDto;
import com.epilogue.dto.request.user.UpdateInfoRequestDto;
import com.epilogue.dto.request.user.UpdatePasswordRequestDto;
import com.epilogue.dto.response.user.UserDTO;
import com.epilogue.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Tag(name = "User Controller", description = "회원 관련 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class UserController {
    private final UserService userService;

    @Operation(summary = "회원가입 API")
    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/user/join")
    public ResponseEntity<?> join(@Parameter(description = "회원가입 요청 DTO") @RequestBody JoinRequestDto joinRequestDto) {
        userService.join(joinRequestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "아이디 중복 검증 API")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "true", description = "중복 O"),
            @ApiResponse(responseCode = "false", description = "중복 X"),
    })
    @PostMapping("/user/id/check")
    public ResponseEntity<?> check(@Parameter(description = "중복 검증할 아이디") @RequestBody IdCheckRequestDto idCheckRequestDto) {
        Boolean userIdCheck = userService.check(idCheckRequestDto);
        return new ResponseEntity<>(userIdCheck, HttpStatus.OK);
    }

    @Operation(summary = "비밀번호 변경 API")
    @ApiResponse(responseCode = "200", description = "성공")
    @PutMapping("/user/password")
    public ResponseEntity<?> updatePassword(Principal principal, @Parameter(description = "변경할 비밀번호") @RequestBody UpdatePasswordRequestDto updatePasswordRequestDto) {
        String loginUserId = principal.getName();
        userService.updatePassword(loginUserId, updatePasswordRequestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "회원 정보 조회 API")
    @ApiResponse(responseCode = "200", description = "성공")
    @GetMapping("/user")
    public ResponseEntity<?> userInfo(Principal principal) {
        String loginUserId = principal.getName();
        UserDTO userDTO = userService.userInfo(loginUserId);
        return new ResponseEntity<>(userDTO, HttpStatus.OK);
    }

    @Operation(summary = "회원 정보 수정 API")
    @ApiResponse(responseCode = "200", description = "성공")
    @PutMapping("/user")
    public ResponseEntity<?> updateUserInfo(Principal principal, @Parameter(description = "변경할 유저 정보") @RequestBody UpdateInfoRequestDto updateInfoRequestDto) {
        String loginUserId = principal.getName();
        userService.updateUserInfo(loginUserId, updateInfoRequestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @Operation(summary = "회원 탈퇴 API")
    @ApiResponse(responseCode = "200", description = "성공")
    @DeleteMapping("/user")
    public ResponseEntity<?> deleteMember(Principal principal) {
        String loginUserId = principal.getName();
        userService.deleteMember(loginUserId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
