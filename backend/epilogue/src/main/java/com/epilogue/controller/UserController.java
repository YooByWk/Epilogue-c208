package com.epilogue.controller;

import com.epilogue.dto.request.user.JoinRequestDto;
import com.epilogue.service.UserService;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.Map;

@Tag(name = "User Controller", description = "회원 관련 API")
@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class UserController {
    private final UserService userService;

    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/user/join")
    public ResponseEntity<?> join(@Parameter(description = "회원가입 요청 DTO") @RequestBody JoinRequestDto joinRequestDto) {
        userService.join(joinRequestDto);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/user/id/check")
    public ResponseEntity<?> check(@Parameter(description = "아이디") Map<String, String> userIdMap) {
        Boolean userIdCheck = userService.check(userIdMap.get("userId"));
        return new ResponseEntity<>(userIdCheck, HttpStatus.OK);
    }

    @ApiResponse(responseCode = "200", description = "성공")
    @PostMapping("/user/password")
    public ResponseEntity<?> updatePassword(Principal principal, @Parameter(description = "변경할 비밀번호") Map<String, String> passwordMap) {
        String loginUserId = principal.getName();
        userService.updatePassword(loginUserId, passwordMap.get("password"));
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
