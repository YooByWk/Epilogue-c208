package com.epilogue.dto.response.user;

import com.epilogue.domain.user.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class UserDTO {

    private String name;
    private String userId;
    private String mobile;
    private String birth;

    public UserDTO(User user) {
        this.name = user.getName();
        this.userId = user.getUserId();
        this.mobile = user.getMobile();
        this.birth = user.getBirth();
    }
}