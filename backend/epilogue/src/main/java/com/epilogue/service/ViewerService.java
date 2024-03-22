package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.viewer.Viewer;
import com.epilogue.dto.request.viewer.ViewerListRequestDto;
import com.epilogue.dto.request.viewer.ViewerRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.viewer.ViewerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ViewerService {
    private final ViewerRepository viewerRepository;
    private final UserRepository userRepository;

    public void save(ViewerListRequestDto viewerListRequestDto, Principal principal) {
        List<ViewerRequestDto> viewerList = viewerListRequestDto.getViewerList();

        User user = userRepository.findByUserId(principal.getName());

        for (ViewerRequestDto v : viewerList) {
            Viewer viewer = Viewer.builder()
                    .will(user.getWill())
                    .viewerName(v.getViewerName())
                    .viewerEmail(v.getViewerEmail())
                    .viewerMobile(v.getViewerMobile())
                    .build();

            viewerRepository.save(viewer);
        }
    }
}
