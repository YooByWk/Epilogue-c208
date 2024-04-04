package com.epilogue.dto.response.user;

import com.epilogue.domain.user.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

public class CustomUserDetails implements UserDetails {

    private final User user;

    public CustomUserDetails(User user) {
        this.user = user;
    }

    // 권환을 확인하는 메서드 (role)
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collection = new ArrayList<>();
        collection.add((GrantedAuthority) () -> "성공");
        return collection;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    // 주의 : getUsername() 메소드이지만 userId 반환
    @Override
    public String getUsername() {
        return user.getUserId();
    }

    // 계정이 만료되지 않음을 확인
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // 계정이 막히지 않음을 확인
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 사용자의 자격 증명(암호)이 만료되었는지 여부
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 계정의 활성화 여부 리턴
    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public String toString() {
        return "CustomUserDetails{" +
                "user=" + user +
                '}';
    }
}
